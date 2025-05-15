output "azure_firewall_public_ip" {
  description = "Azure Firewall Public IP address"
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "azure_firewall_private_ip" {
  description = "Azure Firewall Private IP address"
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

output "route_table_id" {
  description = "ID of the created Route Table"
  value       = azurerm_route_table.route_table.id
}