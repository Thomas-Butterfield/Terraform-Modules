output "id" {
  description = "The ID of the App Config Key"
  value       = azurerm_app_configuration_key.config.id
}

output "name" {
  description = "The Name of the App Config Key"
  value       = azurerm_app_configuration_key.config.name
}
