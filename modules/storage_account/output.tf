output "id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.stg.id
}

output "name" {
  description = "The Name of the Storage Account"
  value       = azurerm_storage_account.stg.name
}

output "primary_blob_endpoint" {
  description = "The Primary Blob Endpoint URL for the Storage Account"
  value       = azurerm_storage_account.stg.primary_blob_endpoint
}

output "primary_access_key" {
  description = "The Primary Access Key for the Storage Account"
  value       = azurerm_storage_account.stg.primary_access_key
}

output "containers" {
  description = "The Containers module object"
  value       = module.container
}

output "queues" {
  description = "The Queues module object"
  value       = module.queue
}

output "data_lake_filesystems" {
  description = "The data Lake Filesystem module object"
  value       = module.data_lake_filesystem
}

output "file_share" {
  description = "The File Shares module object"
  value       = module.file_share
}

output "identity" {
  description = " The Identity object for the Storage Account"
  value       = try(azurerm_storage_account.stg.identity, null)
}

output "rbac_id" {
  description = " The Principal ID for the Service Principal associated with the Identity of this Storage Account. (Extracted from the identity block)"
  value       = try(azurerm_storage_account.stg.identity.0.principal_id, null)
}

output "backup_container_id" {
  description = "The ID of the Backup Storage Account Container"
  value       = try(azurerm_backup_container_storage_account.container["enabled"].id, null)
}


output "primary_web_host" {
  description = "The Primary Web Hostname for the Storage Account"
  value       = azurerm_storage_account.stg.primary_web_host
}

output "primary_connection_string" {
  description = "The Primary Connection String for the Storage Account"
  value       = try(azurerm_storage_account.stg.primary_connection_string, null)
}

output "primary_blob_connection_string" {
  description = "The Primary Blob Connection String for the Storage Account"
  value       = try(azurerm_storage_account.stg.primary_blob_connection_string, null)
}
