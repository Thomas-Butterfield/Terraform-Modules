output "id" {
  description = "The ID of the Virtual Network Gateway"
  value       = azurerm_virtual_network_gateway.vngw.id
}

output "name" {
  description = "The Name of the Virtual Network Gateway"
  value       = azurerm_virtual_network_gateway.vngw.name
}
