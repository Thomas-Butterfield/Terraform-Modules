output "id" {
  description = "The ID of the ServiceBus Namespace"
  value       = azurerm_servicebus_namespace.namespace.id
}

output "name" {
  description = "The name of the ServiceBus Namespace"
  value       = azurerm_servicebus_namespace.namespace.name
}
