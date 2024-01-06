output "id" {
  description = "The ID of the Storage Queue"
  value       = azurerm_storage_queue.queue.id
}

output "name" {
  description = "The Name of the Storage Queue"
  value       = azurerm_storage_queue.queue.name
}
