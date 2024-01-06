output "id" {
  description = "The ID of the Private DNS Zone"
  value       = azurerm_private_dns_zone.private_dns.id
}

output "name" {
  description = "The Name of the Private DNS Zone"
  value       = azurerm_private_dns_zone.private_dns.name
}
