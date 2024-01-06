output "id" {
  description = "The ID of the Storage File Share"
  value       = azurerm_storage_share.fs.id
}

output "name" {
  description = "The Name of the Storage File Share"
  value       = azurerm_storage_share.fs.name
}

output "url" {
  description = "The URL of the Storage File Share"
  value       = azurerm_storage_share.fs.url
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this Storage File Share"
  value       = azurerm_storage_share.fs.resource_manager_id
}

output "file_share_directories" {
  description = "The File Share Directories of this Storage File Share"
  value       = module.file_share_directory
}
