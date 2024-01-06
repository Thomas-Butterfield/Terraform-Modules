output "id" {
  description = "The ID of the App Service Environment"
  value       = azurerm_app_service_environment.ase.id
}

output "name" {
  description = "The Name of the App Service Environment"
  value       = azurerm_app_service_environment.ase.name
}

output "internal_ip_address" {
  description = "IP address of internal load balancer of the App Service Environment"
  value       = azurerm_app_service_environment.ase.internal_ip_address
}

output "location" {
  description = "The location where the App Service Environment exists"
  value       = azurerm_app_service_environment.ase.location
}

output "outbound_ip_addresses" {
  description = "List of outbound IP addresses of the App Service Environment"
  value       = azurerm_app_service_environment.ase.outbound_ip_addresses
}

output "service_ip_address" {
  description = "IP address of service endpoint of the App Service Environment"
  value       = azurerm_app_service_environment.ase.service_ip_address
}
