variable "name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "location" {
  description = "The location/region where the Key Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU name of the Key Vault"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}