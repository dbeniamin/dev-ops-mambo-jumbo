provider "azurerm" {
  features {}
}

# Get existing resources
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

# Deploy the firewall module
module "afw" {
  source                 = "./modules/afw"
  unique_id              = var.unique_id
  location               = var.location
  resource_group_name    = var.rg_name
  vnet_name              = var.vnet_name
  vnet_id                = data.azurerm_virtual_network.vnet.id
  firewall_subnet_prefix = local.fw_subnet_name
  firewall_subnet_cidr   = local.fw_subnet_prefix
  aks_subnet_id          = data.azurerm_subnet.aks_subnet.id
  aks_loadbalancer_ip    = var.aks_loadbalancer_ip
}