output "id" {
  description = "The ID of the Azure Active Directory Domain Service"
  value       = azurerm_active_directory_domain_service.aadds.id
}
output "name" {
  description = "The Name of the Azure Active Directory Domain Service"
  value       = azurerm_active_directory_domain_service.aadds.name
}
output "deployment_id" {
  description = "A unique ID for the managed domain deployment"
  value       = azurerm_active_directory_domain_service.aadds.deployment_id
}
output "resource_id" {
  description = "The Azure resource ID for the domain service"
  value       = azurerm_active_directory_domain_service.aadds.resource_id
}
output "domain_name" {
  description = "The Domain Name of the Azure Active Directory Domain Service"
  value       = azurerm_active_directory_domain_service.aadds.domain_name
}
output "secure_ldap" {
  description = "Secure LDAP block containing the publicly routable IP address for LDAPS clients to connect to this AADDS"
  value       = try(azurerm_active_directory_domain_service.aadds.secure_ldap[0], null)
}
output "domain_controller_ip_addresses" {
  description = "A list of subnet IP addresses for the domain controllers in the initial Replica Set, typically two"
  value       = try(azurerm_active_directory_domain_service.aadds.initial_replica_set[0].domain_controller_ip_addresses, null)
}
output "initial_replica_set_external_access_ip_address" {
  description = "The publicly routable IP address for the domain controllers in the initial Replica Set"
  value       = try(azurerm_active_directory_domain_service.aadds.initial_replica_set[0].external_access_ip_address, null)
}
output "service_status" {
  description = "The current service status for the initial Replica Set"
  value       = try(azurerm_active_directory_domain_service.aadds.initial_replica_set[0].service_status, null)
}
