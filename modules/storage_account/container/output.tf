output "id" {
  description = "The ID of the Storage Container"
  value       = azurerm_storage_container.stg.id
}

output "name" {
  description = "The Name of the Storage Container"
  value       = azurerm_storage_container.stg.name
}

output "blobs" {
  description = "The Blob module object"
  value       = module.blob
}

output "has_immutability_policy" {
  description = "(Bool) Immutability Policy configured on this Storage Container"
  value       = azurerm_storage_container.stg.has_immutability_policy
}

output "has_legal_hold" {
  description = "(Bool) Legal Hold configured on this Storage Container"
  value       = azurerm_storage_container.stg.has_legal_hold
}
