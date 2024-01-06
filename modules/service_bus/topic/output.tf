output "id" {
  description = "The ID of the ServiceBus Topic"
  value       = azurerm_servicebus_topic.topic.id
}

output "name" {
  description = "The name of the ServiceBus Topic"
  value       = azurerm_servicebus_topic.topic.name
}

output "topic_auth_rules" {
  description = "The Topic Authorization Rules associated with this Topic"
  value       = module.topic_auth_rules
}

output "topic_subscriptions" {
  description = "The Topic Subscriptions associated with this Topic"
  value       = module.topic_subscriptions
}
