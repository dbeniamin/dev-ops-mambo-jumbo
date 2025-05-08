variable "location" {
  description = "The location/region where resources will be created"
  type        = string
  default     = "westeurope"
}

variable "name_prefix" {
  type        = string
  description = "The prefix to use for resource names."
}

variable "aad_group_object_id" {
  type        = string
  description = "The object ID of the Azure AD group for AKS admin access."
}

variable "creator_tag" {
  description = "The value for the Creator tag"
  type        = string
  default     = "beniamin_drimus@epam.com"
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