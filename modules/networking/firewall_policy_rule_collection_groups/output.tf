output "id" {
  description = "The ID of the Firewall Policy Rule Collection Group"
  value       = azurerm_firewall_policy_rule_collection_group.polgroup.id
}
output "name" {
  description = "The Name of the Firewall Policy Rule Collection Group"
  value       = azurerm_firewall_policy_rule_collection_group.polgroup.name
}
