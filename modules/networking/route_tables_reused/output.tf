output "id" {
  description = "The ID of the Route Table"
  value       = data.azurerm_route_table.rt.id
}

output "name" {
  description = "The Name of the Route Table"
  value       = data.azurerm_route_table.rt.name
}

output "route" {
  description = "One or more route blocks"
  value       = data.azurerm_route_table.rt.route
}

output "subnets" {
  description = "The collection of Subnets associated with this route table"
  value       = data.azurerm_route_table.rt.subnets
}
