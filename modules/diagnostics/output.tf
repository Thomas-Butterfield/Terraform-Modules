output "id" {
  description = "The ID of the Diagnostic Setting"
  value       = { for k, v in azurerm_monitor_diagnostic_setting.diagnostics : k => v.id }
}
