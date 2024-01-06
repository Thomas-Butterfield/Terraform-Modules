output "id" {
  description = "The ID of the Automation Account"
  value       = azurerm_automation_account.auto_account.id
}
output "name" {
  description = "The Name of the Automation Account"
  value       = azurerm_automation_account.auto_account.name
}
output "dsc_server_endpoint" {
  description = "The DSC Server Endpoint associated with this Automation Account"
  value       = azurerm_automation_account.auto_account.dsc_server_endpoint
}
output "la_linked_service_id" {
  description = "The ID of the Log Analytics Linked Service associated with this Automation Account"
  value       = { for k, v in azurerm_log_analytics_linked_service.auto_account_la_link : k => v.id }
}
output "la_linked_service_name" {
  description = "The Name of the Log Analytics Linked Service associated with this Automation Account"
  value       = { for k, v in azurerm_log_analytics_linked_service.auto_account_la_link : k => v.name }
}
