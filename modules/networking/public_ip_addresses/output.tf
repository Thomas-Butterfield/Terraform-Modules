output "id" {
  description = "The ID of the Public IP"
  value       = azurerm_public_ip.pip.id
}

output "ip_address" {
  description = "The IP address of the Public IP"
  value       = azurerm_public_ip.pip.ip_address
}

output "fqdn" {
  description = "The Fully Qualified Domain Name of the Public IP"
  value       = azurerm_public_ip.pip.fqdn
}
