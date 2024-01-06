output "id" {
  description = "The ID of the Application Insights resource"
  value       = azurerm_application_insights.app_insights.id
}

output "name" {
  description = "The Name of the Application Insights resource"
  value       = azurerm_application_insights.app_insights.name
}

output "app_id" {
  description = "The App ID associated with this Application Insights resource"
  value       = azurerm_application_insights.app_insights.app_id
}

output "instrumentation_key" {
  description = "The Instrumentation Key for this Application Insights resource"
  value       = azurerm_application_insights.app_insights.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "The Connection String for this Application Insights resource. (Sensitive)"
  value       = azurerm_application_insights.app_insights.connection_string
  sensitive   = true
}
