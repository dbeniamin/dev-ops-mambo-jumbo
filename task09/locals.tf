locals {
  fw_subnet_name   = "AzureFirewallSubnet"            # Required name for Azure Firewall subnet
  fw_subnet_prefix = cidrsubnet(var.vnet_space, 8, 1) # Creating a /24 subnet for the firewall
  resource_prefix  = var.unique_id
}