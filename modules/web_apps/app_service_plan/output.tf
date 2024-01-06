output "id" {
  description = "The ID of the Service Plan"
  value       = azurerm_service_plan.asp.id
}

output "name" {
  description = "The Name of the Service Plan"
  value       = azurerm_service_plan.asp.name
}

output "kind" {
  description = "A string representing the Kind of Service Plan"
  value       = azurerm_service_plan.asp.kind
}

output "reserved" {
  description = "Whether this is a reserved Service Plan Type. true if os_type is Linux, otherwise false"
  value       = azurerm_service_plan.asp.reserved
}

output "ase_id" {
  description = "The ID of the App Service Environment to create this Service Plan in"
  value       = var.app_service_environment_id
}
