output "id" {
  description = "The ID of the Express Route Circuit"
  value       = azurerm_express_route_circuit.circuit.id
}
output "name" {
  description = "The Name of the Express Route Circuit"
  value       = azurerm_express_route_circuit.circuit.name
}
output "service_key" {
  description = "The Service Key of the Express Route Circuit"
  value       = azurerm_express_route_circuit.circuit.service_key
  sensitive   = true
}
output "service_provider_provisioning_state" {
  description = "The Service Provider Provisioning State of the Express Route Circuit"
  value       = azurerm_express_route_circuit.circuit.service_provider_provisioning_state
}
