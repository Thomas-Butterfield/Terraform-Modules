output "id" {
  description = "The ID of the Windows Web App Slot"
  value       = azurerm_windows_web_app_slot.webapp.id
}

output "name" {
  description = "The Name of the Windows Web App Slot"
  value       = azurerm_windows_web_app_slot.webapp.name
}

output "app_metadata" {
  description = "App Metadata block"
  value       = azurerm_windows_web_app_slot.webapp.app_metadata
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record"
  value       = azurerm_windows_web_app_slot.webapp.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname of the Windows Web App Slot"
  value       = azurerm_windows_web_app_slot.webapp.default_hostname
}

output "identity" {
  description = "An identity block, which contains the Managed Service Identity information for this App Service"
  value       = azurerm_windows_web_app_slot.webapp.identity
}

output "kind" {
  description = "The Kind value for this Windows Web App Slot"
  value       = azurerm_windows_web_app_slot.webapp.kind
}

output "outbound_ip_address_list" {
  description = "A list of outbound IP addresses - such as [\"52.23.25.3\", \"52.143.43.12\"]"
  value       = azurerm_windows_web_app_slot.webapp.outbound_ip_address_list
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12"
  value       = azurerm_windows_web_app_slot.webapp.outbound_ip_addresses
}

output "possible_outbound_ip_address_list" {
  description = "A possible_outbound_ip_address_list block as defined below"
  value       = azurerm_windows_web_app_slot.webapp.possible_outbound_ip_address_list
}

output "possible_outbound_ip_addresses" {
  description = "A comma-separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses"
  value       = azurerm_windows_web_app_slot.webapp.possible_outbound_ip_addresses
}

output "site_credential" {
  description = "A site_credential block containing name and password"
  value       = azurerm_windows_web_app_slot.webapp.site_credential
}
