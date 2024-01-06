output "id" {
  description = "The ID of the Virtual Network Gateway Connection"
  value       = azurerm_virtual_network_gateway_connection.vngwc.id
}

output "name" {
  description = "The Name of the Virtual Network Gateway Connection"
  value       = azurerm_virtual_network_gateway_connection.vngwc.name
}
