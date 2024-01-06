output "id" {
  description = "The ID of the Express Route Connection"
  value       = azurerm_express_route_circuit_connection.er_circuit_conn.id
}
output "name" {
  description = "The Name of the Express Route Connection"
  value       = azurerm_express_route_circuit_connection.er_circuit_conn.name
}
