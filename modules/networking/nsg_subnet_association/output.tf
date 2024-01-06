output "id" {
  description = "The ID of the NSG/Subnet Association"
  value       = { for k, v in azurerm_subnet_network_security_group_association.nsg_vnet_association : k => v.id }
}
