variable "acr_name" {
  description = "The name of the container registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the container registry will be created"
  type        = string
}

variable "sku" {
  description = "The SKU name of the container registry"
  type        = string
  default     = "Basic"
}

variable "image_name" {
  description = "The name of the Docker image to build"
  type        = string
}

variable "context_path" {
  description = "The URL path to the Docker build context"
  type        = string
}

variable "context_access_token" {
  description = "The access token for the context path"
  type        = string
  sensitive   = true
}

variable "build_task_depends_on" {
  description = "List of resources the build task depends on"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}