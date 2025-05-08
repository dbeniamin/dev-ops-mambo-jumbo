output "acr_id" {
  description = "The ID of the container registry"
  value       = azurerm_container_registry.this.id
}

output "acr_login_server" {
  description = "The login server URL of the container registry"
  value       = azurerm_container_registry.this.login_server
}

output "acr_admin_username" {
  description = "The admin username of the container registry"
  value       = azurerm_container_registry.this.admin_username
}

output "acr_admin_password" {
  description = "The admin password of the container registry"
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}

output "image_name" {
  description = "The full name of the Docker image including registry"
  value       = "${azurerm_container_registry.this.login_server}/${var.image_name}:latest"
}