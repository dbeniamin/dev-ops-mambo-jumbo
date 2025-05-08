variable "name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The location/region where the AKS cluster will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "default_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
  default     = "system"
}

variable "default_node_pool_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "default_node_pool_size" {
  description = "The size of the VMs in the default node pool"
  type        = string
  default     = "Standard_D2ads_v5"
}

variable "default_node_pool_os_disk_type" {
  description = "The OS disk type of the default node pool"
  type        = string
  default     = "Ephemeral"
}

variable "acr_id" {
  description = "The ID of the ACR to pull images from"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to get secrets from"
  type        = string
}

variable "aad_group_object_id" {
  type        = string
  description = "The object ID of the Azure AD group for AKS admin access."
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

# 🔄 Updated from aks_identity_id (a full resource ID string)
#     to aks_identity_name (name only), since the full ID is now looked up via a data block.
variable "aks_identity_name" {
  type        = string
  description = "The name of the user-assigned identity to be used by AKS."
}

variable "default_node_pool_os_disk_size_gb" {
  description = "The size of the OS disk in GB for the default node pool"
  type        = number
  default     = 60
}
