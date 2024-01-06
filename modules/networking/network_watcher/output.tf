output "id" {
  description = "The ID of the Network Watcher"
  value       = azurerm_network_watcher.netwatcher.id
}
output "name" {
  description = "The Name of the Network Watcher"
  value       = azurerm_network_watcher.netwatcher.name
}
output "location" {
  description = "The Location of the Network Watcher"
  value       = azurerm_network_watcher.netwatcher.location
}
output "resource_group_name" {
  description = "The RG Name of the Network Watcher"
  value       = azurerm_network_watcher.netwatcher.resource_group_name
}
