output "id" {
  description = "The ID of the ServiceBus Topic Authorization Rule"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.id
}

output "name" {
  description = "The Name of the ServiceBus Topic Authorization Rule"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.name
}