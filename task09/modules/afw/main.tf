# Create a subnet for Azure Firewall in the existing VNET
resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_prefix
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.firewall_subnet_cidr]
}

# Create a public IP for Azure Firewall
resource "azurerm_public_ip" "firewall_pip" {
  name                = local.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

# Create Azure Firewall
resource "azurerm_firewall" "firewall" {
  name                = local.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

# Create Route Table
resource "azurerm_route_table" "route_table" {
  name                = local.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Internet route through firewall
  route {
    name                   = "ToFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

  # Add specific routes for AKS services
  route {
    name           = "AKSManagementRoute"
    address_prefix = "AzureCloud.NorthEurope"
    next_hop_type  = "Internet"
  }

  # Fixed: Using the non-deprecated property
  bgp_route_propagation_enabled = false
}

# Associate Route Table with AKS subnet
resource "azurerm_subnet_route_table_association" "aks_route_association" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.route_table.id
}

# Create NAT Rule Collection for inbound traffic to NGINX
resource "azurerm_firewall_nat_rule_collection" "nat_rules" {
  name                = local.rule_collections.nat.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.rule_collections.nat.priority
  action              = local.rule_collections.nat.action

  dynamic "rule" {
    for_each = local.nat_rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
      translated_address    = var.aks_loadbalancer_ip
      translated_port       = rule.value.translated_port
    }
  }
}

# Create Network Rule Collection for outbound traffic
resource "azurerm_firewall_network_rule_collection" "network_rules" {
  name                = local.rule_collections.network.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.rule_collections.network.priority
  action              = local.rule_collections.network.action

  dynamic "rule" {
    for_each = local.network_rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

# Create Application Rule Collection
resource "azurerm_firewall_application_rule_collection" "app_rules" {
  name                = local.rule_collections.application.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.rule_collections.application.priority
  action              = local.rule_collections.application.action

  rule {
    name             = "AllowAKSOutbound"
    source_addresses = ["*"]
    target_fqdns     = local.app_rule_fqdns

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }
}