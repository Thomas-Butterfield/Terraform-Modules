output "id" {
  description = "The ID of the App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.id
}

output "name" {
  description = "The Name of the App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.name
}

output "dns_suffix" {
  description = "The DNS suffix for this App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.dns_suffix
}

output "external_inbound_ip_addresses" {
  description = "The external inbound IP addresses of the App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.external_inbound_ip_addresses
}

output "inbound_network_dependencies" {
  description = "An Inbound Network Dependencies block as defined below"
  value       = azurerm_app_service_environment_v3.ase.inbound_network_dependencies
}

output "internal_inbound_ip_addresses" {
  description = "The internal inbound IP addresses of the App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.internal_inbound_ip_addresses
}

output "ip_ssl_address_count" {
  description = "The number of IP SSL addresses reserved for the App Service Environment V3"
  value       = azurerm_app_service_environment_v3.ase.ip_ssl_address_count
}

output "linux_outbound_ip_addresses" {
  description = "Outbound addresses of Linux based Apps in this App Service Environment V3"
  value       = azurerm_app_service_environment.ase.linux_outbound_ip_addresses
}

output "location" {
  description = "The location where the App Service Environment exists"
  value       = azurerm_app_service_environment.ase.location
}

output "pricing_tier" {
  description = "Pricing tier for the front end instances"
  value       = azurerm_app_service_environment.ase.pricing_tier
}

output "windows_outbound_ip_addresses" {
  description = "Outbound addresses of Windows based Apps in this App Service Environment V3"
  value       = azurerm_app_service_environment.ase.windows_outbound_ip_addresses
}
