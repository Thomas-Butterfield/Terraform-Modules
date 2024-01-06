output "id" {
  description = "The ID of the Bastion Host"
  value       = azurerm_bastion_host.bastion.id
}

output "name" {
  description = "The Name of the Bastion Host"
  value       = azurerm_bastion_host.bastion.name
}
