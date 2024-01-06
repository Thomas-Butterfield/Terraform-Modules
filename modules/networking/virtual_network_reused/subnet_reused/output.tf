output "id" {
  description = "The ID of the Data Subnet"
  value       = data.azurerm_subnet.subnet.id
}

output "name" {
  description = "The Name of the Data Subnet"
  value       = data.azurerm_subnet.subnet.name
}
