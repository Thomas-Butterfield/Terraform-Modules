output "id" {
  description = "The ID of the Public IP Prefix"
  value       = azurerm_public_ip_prefix.pip.id
}

output "name" {
  description = "The Name of the Public IP Prefix"
  value       = azurerm_public_ip_prefix.pip.name
}
