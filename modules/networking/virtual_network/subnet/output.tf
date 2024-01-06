output "id" {
  description = "The ID of the Subnet"
  value       = azurerm_subnet.subnet.id
}

output "name" {
  description = "The Name of the Subnet"
  value       = azurerm_subnet.subnet.name
}

output "cidr" {
  description = "The CIDR (Address Prefixes) of the Subnet"
  value       = var.address_prefixes
}
