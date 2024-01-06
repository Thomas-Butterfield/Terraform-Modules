output "id" {
  description = "The ID of the Linux Web App"
  value       = azurerm_linux_web_app.webapp.id
}

output "name" {
  description = "The Name of the Linux Web App"
  value       = azurerm_linux_web_app.webapp.name
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record"
  value       = azurerm_linux_web_app.webapp.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname of the Linux Web App"
  value       = azurerm_linux_web_app.webapp.default_hostname
}

output "identity" {
  description = "An identity block, which contains the Managed Service Identity information for this App Service"
  value       = azurerm_linux_web_app.webapp.identity
}

output "kind" {
  description = "The Kind value for this Linux Web App"
  value       = azurerm_linux_web_app.webapp.kind
}

output "outbound_ip_address_list" {
  description = "A list of outbound IP addresses - such as [\"52.23.25.3\", \"52.143.43.12\"]"
  value       = azurerm_linux_web_app.webapp.outbound_ip_address_list
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12"
  value       = azurerm_linux_web_app.webapp.outbound_ip_addresses
}

output "possible_outbound_ip_address_list" {
  description = "A possible_outbound_ip_address_list block as defined below"
  value       = azurerm_linux_web_app.webapp.possible_outbound_ip_address_list
}

output "possible_outbound_ip_addresses" {
  description = "A comma-separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses"
  value       = azurerm_linux_web_app.webapp.possible_outbound_ip_addresses
}

output "site_credential" {
  description = "A site_credential block containing name and password"
  value       = azurerm_linux_web_app.webapp.site_credential
}
