variable "unique_id" {
  description = "Unique identifier for resource naming"
  type        = string
}

variable "location" {
  description = "Azure region for resources deployment"
  type        = string
}

variable "rg_name" {
  description = "Existing resource group name"
  type        = string
}

variable "vnet_name" {
  description = "Existing Virtual network name"
  type        = string
}

variable "vnet_space" {
  description = "Existing Virtual Network Address Space"
  type        = string
}

variable "subnet_name" {
  description = "Existing Subnet name (AKS Cluster subnet)"
  type        = string
}

variable "subnet_space" {
  description = "Existing Subnet Address Space (AKS Cluster subnet)"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS load-balancer public IP address"
  type        = string
}