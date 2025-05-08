variable "name" {
  description = "The name of the Azure Container App"
  type        = string
}

variable "environment_name" {
  description = "The name of the Azure Container App Environment"
  type        = string
}

variable "location" {
  description = "The location/region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "image_name" {
  description = "The name of the Docker image including registry"
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "key_vault_uri" {
  description = "The URI of the Key Vault"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "The name of the Key Vault secret for Redis hostname"
  type        = string
  default     = "redis-hostname"
}

variable "redis_password_secret_name" {
  description = "The name of the Key Vault secret for Redis password"
  type        = string
  default     = "redis-password"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "acr_name" {
  description = "Name of the Azure Container Registry without the .azurecr.io suffix"
  type        = string
}