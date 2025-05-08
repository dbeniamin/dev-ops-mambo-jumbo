resource "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = var.app_source_dir
  output_path = "${path.root}/${var.app_archive_name}"
}

resource "time_static" "sas_start" {
  # This will generate a static time for SAS start
}

resource "time_offset" "sas_expiry" {
  base_rfc3339   = time_static.sas_start.rfc3339
  offset_years   = 1
  offset_months  = 0
  offset_days    = 0
  offset_hours   = 0
  offset_minutes = 0
  offset_seconds = 0
}

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}

resource "azurerm_storage_container" "app_content" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "app_archive" {
  name                   = var.app_archive_name
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.app_content.name
  type                   = "Block"
  source                 = archive_file.app.output_path
}

data "azurerm_storage_account_blob_container_sas" "sas" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.app_content.name

  start  = time_static.sas_start.rfc3339
  expiry = time_offset.sas_expiry.rfc3339

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}