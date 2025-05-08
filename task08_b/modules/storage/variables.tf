variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the storage account will be created"
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for this storage account"
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
  default     = "app-content"
}

variable "container_access_type" {
  description = "The access type of the storage container"
  type        = string
  default     = "private"
}

variable "app_source_dir" {
  description = "The directory containing the application source code"
  type        = string
}

variable "app_archive_name" {
  description = "The name of the application archive file"
  type        = string
  default     = "app.tar.gz"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}