variable "secret_provider_template_path" {
  description = "Path to the secret provider template file"
  type        = string
}

variable "deployment_template_path" {
  description = "Path to the deployment template file"
  type        = string
}

variable "service_manifest_path" {
  description = "Path to the service manifest file"
  type        = string
}

variable "image_name" {
  description = "Name of the container image"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the secret for Redis hostname in Key Vault"
  type        = string
}

variable "redis_password_secret_name" {
  description = "Name of the secret for Redis password in Key Vault"
  type        = string
}

variable "redis_url_secret_name" {
  description = "Name of the secret for Redis URL in Key Vault"
  type        = string
  default     = "redishostname"
}

variable "aks_identity_id" {
  description = "ID of the AKS identity"
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server address"
  type        = string
}

variable "image_tag" {
  description = "Tag for the container image"
  type        = string
  default     = "latest"
}
