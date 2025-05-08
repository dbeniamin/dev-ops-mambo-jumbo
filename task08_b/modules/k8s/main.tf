resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile(var.secret_provider_template_path, {
    tenant_id                  = var.tenant_id
    keyvault_name              = var.keyvault_name
    redis_host_secret          = var.redis_hostname_secret_name
    redis_password_secret_name = var.redis_password_secret_name
    aks_kv_access_identity_id  = var.aks_identity_id
    kv_name                    = var.keyvault_name
    redis_url_secret_name      = var.redis_url_secret_name
  })
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile(var.deployment_template_path, {
    image_name        = var.image_name
    tenant_id         = var.tenant_id
    keyvault_name     = var.keyvault_name
    redis_host_secret = var.redis_hostname_secret_name
    redis_pwd_secret  = var.redis_password_secret_name
    acr_login_server  = var.acr_login_server
    app_image_name    = var.image_name
    image_tag         = var.image_tag
  })
}

resource "kubectl_manifest" "service" {
  yaml_body = file(var.service_manifest_path)
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "app"
    namespace = "default"
  }
}