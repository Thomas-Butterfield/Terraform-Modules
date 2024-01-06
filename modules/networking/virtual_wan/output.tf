output "id" {
  description = "The ID of the Virtual WAN"
  value       = azurerm_virtual_wan.vwan.id
}

output "name" {
  description = "The Name of the Virtual WAN"
  value       = azurerm_virtual_wan.vwan.name
}

output "virtual_hubs" {
  description = "The Virtual Hubs module object"
  value       = module.hubs
}

output "virtual_wan" {
  description = "The Virtual WAN resource object"
  value       = azurerm_virtual_wan.vwan
}
