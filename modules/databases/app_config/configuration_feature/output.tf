output "id" {
  description = "The ID of the App Config Feature"
  value       = azurerm_app_configuration_feature.config.id
}

output "name" {
  description = "The Name of the App Config Feature"
  value       = azurerm_app_configuration_feature.config.name
}
