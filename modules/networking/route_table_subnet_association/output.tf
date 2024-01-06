output "id" {
  description = "The ID of the Route Table/Subnet Association"
  value       = { for k, v in azurerm_subnet_route_table_association.rt_vnet_association : k => v.id }
}
