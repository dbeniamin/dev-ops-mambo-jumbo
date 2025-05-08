variable "name" {
  description = "The name of the Redis container instance"
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

variable "key_vault_id" {
  description = "The ID of the Key Vault to store secrets"
  type        = string
}

variable "redis_password_secret_name" {
  description = "The name of the Key Vault secret for Redis password"
  type        = string
  default     = "redisprimarykey"
}

variable "redis_hostname_secret_name" {
  description = "The name of the Key Vault secret for Redis hostname"
  type        = string
  default     = "redishostname"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "acr_login_server" {
  description = "The login server for the Azure Container Registry"
  type        = string
}

variable "app_image_name" {
  description = "The name of the application image"
  type        = string
}

variable "image_tag" {
  description = "The tag for the container image"
  type        = string
}