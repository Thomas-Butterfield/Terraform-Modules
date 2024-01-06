output "id" {
  description = "The ID of the AVD workspace"
  value       = azurerm_virtual_desktop_workspace.avdws.id
}

output "name" {
  description = "The Name of the AVD workspace"
  value       = azurerm_virtual_desktop_workspace.avdws.name
}
