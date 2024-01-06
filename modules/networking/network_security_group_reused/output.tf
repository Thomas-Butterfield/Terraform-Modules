output "id" {
  description = "The ID of the NSG"
  value       = data.azurerm_network_security_group.nsg_obj.id
}

output "name" {
  description = "The Name of the NSG"
  value       = data.azurerm_network_security_group.nsg_obj.name
}
