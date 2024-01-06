output "id" {
  description = "The ID of the Azure Firewall Policy"
  value       = azurerm_firewall_policy.fwpol.id
}

output "name" {
  description = "The Name of the Azure Firewall Policy"
  value       = azurerm_firewall_policy.fwpol.name
}
