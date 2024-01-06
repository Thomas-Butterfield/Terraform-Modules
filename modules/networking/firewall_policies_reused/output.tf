output "id" {
  description = "The ID of the Azure Firewall Policy Data Resource"
  value       = data.azurerm_firewall_policy.fwpol.id
}

output "name" {
  description = "The Name of the Azure Firewall Policy Data Resource"
  value       = data.azurerm_firewall_policy.fwpol.name
}
