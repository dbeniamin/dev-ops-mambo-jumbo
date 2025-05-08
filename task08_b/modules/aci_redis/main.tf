resource "random_password" "redis_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_container_group" "redis" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.name
  os_type             = "Linux"
  tags                = var.tags


  container {
    name   = "redis"
    image  = "${var.acr_login_server}/${var.app_image_name}:${var.image_tag}"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 6379
      protocol = "TCP"
    }

    commands = [
      "redis-server",
      "--protected-mode", "no",
      "--requirepass", random_password.redis_password.result
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  value        = random_password.redis_password.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.key_vault_id
}
