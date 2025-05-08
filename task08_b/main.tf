data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

# Key Vault module
module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.keyvault_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "standard"
  tags                = local.common_tags

  depends_on = [azurerm_resource_group.this]
}

# Redis in ACI module
module "aci_redis" {
  source                     = "./modules/aci_redis"
  name                       = local.redis_aci_name
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  key_vault_id               = module.keyvault.key_vault_id
  redis_password_secret_name = "redisprimarykey"
  redis_hostname_secret_name = "redishostname"
  acr_login_server           = var.acr_login_server
  app_image_name             = var.app_image_name
  image_tag                  = var.image_tag
  tags                       = local.common_tags

  depends_on = [module.keyvault]
}

# Storage Account module
module "storage" {
  source                   = "./modules/storage"
  storage_account_name     = local.sa_name
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_replication_type = "LRS"
  container_name           = "app-content"
  container_access_type    = "private"
  app_source_dir           = local.app_source_dir
  app_archive_name         = local.app_archive_name
  tags                     = local.common_tags

  depends_on = [azurerm_resource_group.this]
}

# Azure Container Registry module
module "acr" {
  source                = "./modules/acr"
  acr_name              = local.acr_name
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  sku                   = "Basic"
  image_name            = local.image_name
  context_path          = module.storage.blob_url
  context_access_token  = module.storage.blob_sas_token
  build_task_depends_on = [module.storage]
  tags                  = local.common_tags

  depends_on = [module.storage]
}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "${local.aks_name}-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.common_tags
}

# Azure Kubernetes Service module
module "aks" {
  source                         = "./modules/aks"
  name                           = local.aks_name
  aks_identity_name              = azurerm_user_assigned_identity.aks.name
  location                       = azurerm_resource_group.this.location
  resource_group_name            = azurerm_resource_group.this.name
  default_node_pool_name         = "system"
  default_node_pool_count        = 1
  default_node_pool_size         = "Standard_D2ads_v5"
  default_node_pool_os_disk_type = "Ephemeral"
  acr_id                         = module.acr.acr_id
  key_vault_id                   = module.keyvault.key_vault_id
  aad_group_object_id            = var.aad_group_object_id
  tags                           = local.common_tags


  depends_on = [module.acr, module.keyvault]
}

resource "time_sleep" "wait_for_aks" {
  depends_on      = [module.aks]
  create_duration = "120s" # Increased wait time
}

# Azure Container App module
module "aca" {
  source                     = "./modules/aca"
  acr_name                   = local.acr_name
  name                       = local.aca_name
  environment_name           = local.aca_env_name
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  image_name                 = module.acr.image_name
  acr_id                     = module.acr.acr_id
  key_vault_id               = module.keyvault.key_vault_id
  key_vault_uri              = module.keyvault.key_vault_uri
  redis_hostname_secret_name = "redisprimarykey"
  redis_password_secret_name = "redishostname"
  tags                       = local.common_tags

  depends_on = [module.acr, module.keyvault, module.aci_redis]
}


# Add extra time for AKS k8s API to be fully available
resource "time_sleep" "wait_for_k8s_api" {
  depends_on      = [module.aks, time_sleep.wait_for_aks]
  create_duration = "60s"
}

# Update k8s module call to remove depends_on and pass providers
module "k8s" {
  source = "./modules/k8s"

  # Your existing variables...
  secret_provider_template_path = "${path.root}/k8s-manifests/secret-provider.yaml.tftpl"
  deployment_template_path      = "${path.root}/k8s-manifests/deployment.yaml.tftpl"
  service_manifest_path         = "${path.root}/k8s-manifests/service.yaml"
  image_name                    = module.acr.image_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  keyvault_name                 = module.keyvault.key_vault_name
  redis_hostname_secret_name    = "redishostname"
  redis_password_secret_name    = "redisprimarykey"
  redis_url_secret_name         = "redishostname"
  aks_identity_id               = azurerm_user_assigned_identity.aks.id
  acr_login_server              = module.acr.acr_login_server
  image_tag                     = var.image_tag

  depends_on = [module.aks, time_sleep.wait_for_aks, time_sleep.wait_for_k8s_api]
}