output "id" {
  description = "The ID of the Subnet"
  value       = azurerm_subnet.subnet.id
}

output "name" {
  description = "The Name of the Subnet"
  value       = azurerm_subnet.subnet.name
}
