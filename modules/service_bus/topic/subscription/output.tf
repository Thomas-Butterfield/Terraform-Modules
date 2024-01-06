output "id" {
  description = "The ID of the ServiceBus Subscription"
  value       = azurerm_servicebus_subscription.subscription.id
}

output "name" {
  description = "The Name of the ServiceBus Subscription"
  value       = azurerm_servicebus_subscription.subscription.name
}

output "subscription_rules" {
  value = merge(module.correlation_filter_rules, module.sql_filter_rules)
}
