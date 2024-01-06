
output "id" {
  description = "The Load Balancer NAT Rule ID"
  value       = azurerm_lb_nat_rule.natrule.id
}
output "name" {
  description = "The Load Balancer NAT Rule Name"
  value       = azurerm_lb_nat_rule.natrule.name
}
