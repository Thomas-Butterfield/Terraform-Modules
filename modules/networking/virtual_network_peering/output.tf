
output "id" {
  description = "The ID of the Virtual Network Peering"
  # value       = var.use_sharedsvc_provider ? azurerm_virtual_network_peering.vnet-peering-sharedsvc[0].id : azurerm_virtual_network_peering.vnet-peering[0].id
  value = azurerm_virtual_network_peering.vnet-peering.id
}

output "name" {
  description = "The Name of the Virtual Network Peering"
  # value       = var.use_sharedsvc_provider ? azurerm_virtual_network_peering.vnet-peering-sharedsvc[0].name : azurerm_virtual_network_peering.vnet-peering[0].name
  value = azurerm_virtual_network_peering.vnet-peering.name
}
