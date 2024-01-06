output "id" {
  description = "The ID of the Management Lock"
  value       = azurerm_management_lock.lock.id
}

output "name" {
  description = "The Name of the Management Lock"
  value       = azurerm_management_lock.lock.name
}
