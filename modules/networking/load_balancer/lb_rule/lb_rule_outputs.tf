
output "id" {
  description = "The Load Balancer Rule ID"
  value       = azurerm_lb_rule.rule.id
}
output "name" {
  description = "The Load Balancer Rule Name"
  value       = azurerm_lb_rule.rule.name
}
