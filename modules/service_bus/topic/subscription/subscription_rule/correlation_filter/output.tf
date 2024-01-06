output "id" {
  description = "The ID of the ServiceBus Subscription Rule"
  value       = azurerm_servicebus_subscription_rule.correlation_filter.id
}
output "name" {
  description = "The Name of the ServiceBus Subscription Rule"
  value       = azurerm_servicebus_subscription_rule.correlation_filter.name
}