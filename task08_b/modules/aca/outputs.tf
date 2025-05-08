output "container_app_id" {
  description = "The ID of the Container App"
  value       = azurerm_container_app.this.id
}

output "container_app_fqdn" {
  description = "The FQDN of the Container App"
  value       = azurerm_container_app.this.ingress[0].fqdn
}

output "container_app_url" {
  description = "The URL of the Container App"
  value       = "https://${azurerm_container_app.this.ingress[0].fqdn}"
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = azurerm_container_app_environment.this.id
}