output "id" {
  description = "The ID of the Storage Account"
  value       = data.azurerm_storage_account.stg.id
}

output "name" {
  description = "The Name of the Storage Account"
  value       = data.azurerm_storage_account.stg.name
}

output "primary_blob_endpoint" {
  description = "The Primary Blob Endpoint URL for the Storage Account"
  value       = data.azurerm_storage_account.stg.primary_blob_endpoint
}

output "primary_access_key" {
  description = "The Primary Access Key for the Storage Account"
  value       = data.azurerm_storage_account.stg.primary_access_key
}

output "primary_web_host" {
  description = "The Primary Web Hostname for the Storage Account"
  value       = data.azurerm_storage_account.stg.primary_web_host
}

output "primary_connection_string" {
  description = "The Primary Connection String for the Storage Account"
  value       = try(data.azurerm_storage_account.stg.primary_connection_string, null)
}

output "primary_blob_connection_string" {
  description = "The Primary Blob Connection String for the Storage Account"
  value       = try(data.azurerm_storage_account.stg.primary_blob_connection_string, null)
}
