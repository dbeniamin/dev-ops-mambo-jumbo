output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint of the storage account"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "blob_sas_token" {
  description = "The SAS token for the blob container"
  value       = data.azurerm_storage_account_blob_container_sas.sas.sas
  sensitive   = true
}

output "blob_url" {
  description = "The URL for the blob archive"
  value       = "${azurerm_storage_account.this.primary_blob_endpoint}${azurerm_storage_container.app_content.name}/${azurerm_storage_blob.app_archive.name}"
}