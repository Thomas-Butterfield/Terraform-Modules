output "id" {
  description = "The ID of the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.id
}

output "name" {
  description = "The Name of the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.name
}

output "workspace_id" {
  description = "The Workspace ID of the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.workspace_id
}

output "primary_shared_key" {
  description = "The Primary Shared Key of the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.primary_shared_key
  sensitive   = true #hide from CLI output
}

output "resource_group_name" {
  description = "The Resource Group Name of the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.resource_group_name
}
