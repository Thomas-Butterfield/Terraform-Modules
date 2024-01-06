output "id" {
  description = "The ID of the Storage File Share Directory"
  value       = azurerm_storage_share_directory.share_directory.id
}

output "name" {
  description = "The Name of the Storage File Share Directory"
  value       = azurerm_storage_share_directory.share_directory.name
}
