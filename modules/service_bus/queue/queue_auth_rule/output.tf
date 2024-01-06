output "id" {
  description = "The ID of the ServiceBus Authorization rule"
  value       = azurerm_servicebus_queue_authorization_rule.queue_auth_rule.id
}

output "name" {
  description = "The Name of the ServiceBus Authorization rule"
  value       = azurerm_servicebus_queue_authorization_rule.queue_auth_rule.name
}