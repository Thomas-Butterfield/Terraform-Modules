output "id" {
  description = "The ID of the Route Table"
  value       = azurerm_route_table.rt.id
}

output "name" {
  description = "The Name of the Route Table"
  value       = azurerm_route_table.rt.name
}
