output "id" {
  description = "The ID of the Express Route Connection"
  value       = azurerm_express_route_circuit_authorization.er_circuit_auth.id
}
output "name" {
  description = "The Name of the Express Route Connection"
  value       = azurerm_express_route_circuit_authorization.er_circuit_auth.name
}
output "authorization_key" {
  description = " The Authorization Key"
  value       = azurerm_express_route_circuit_authorization.er_circuit_auth.authorization_key
}
output "authorization_use_status" {
  description = "The authorization use status"
  value       = azurerm_express_route_circuit_authorization.er_circuit_auth.authorization_use_status
}
