output "id" {
  description = "The ID of the App Config"
  value       = azurerm_app_configuration.config.id
}

output "name" {
  description = "The Name of the App Config"
  value       = azurerm_app_configuration.config.name
}

output "endpoint" {
  description = "The URL of the App Configuration"
  value       = azurerm_app_configuration.config.endpoint
}

output "identity" {
  description = "The managed service identity object"
  value       = azurerm_app_configuration.config.identity
}