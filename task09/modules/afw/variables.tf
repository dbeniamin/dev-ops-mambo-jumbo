variable "unique_id" {
  description = "Unique identifier for resource naming"
  type        = string
}

variable "location" {
  description = "Azure region for resources deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group name"
  type        = string
}

variable "vnet_name" {
  description = "Existing Virtual network name"
  type        = string
}

variable "vnet_id" {
  description = "ID of the existing virtual network"
  type        = string
}

variable "firewall_subnet_prefix" {
  description = "Name prefix for the firewall subnet"
  type        = string
  default     = "AzureFirewallSubnet"
}

variable "firewall_subnet_cidr" {
  description = "CIDR for the firewall subnet"
  type        = string
}

variable "aks_subnet_id" {
  description = "ID of the existing AKS subnet"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS load-balancer public IP address"
  type        = string
}