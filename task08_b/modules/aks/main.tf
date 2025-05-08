data "azurerm_client_config" "current" {}

data "azurerm_user_assigned_identity" "aks" {
  name                = var.aks_identity_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name
  tags                = var.tags

  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.default_node_pool_count
    vm_size         = var.default_node_pool_size
    os_disk_type    = var.default_node_pool_os_disk_type
    os_disk_size_gb = var.default_node_pool_os_disk_size_gb
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.aks.id]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [var.aad_group_object_id]
    azure_rbac_enabled     = true
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = data.azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_user_assigned_identity.aks.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}
