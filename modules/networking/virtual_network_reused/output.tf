output "id" {
  description = "The ID of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.id
}

output "name" {
  description = "The Name of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.name
}

output "resource_group_name" {
  description = "The Resource Group Name of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.resource_group_name
}

output "location" {
  description = "The Location of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.location
}

output "address_space" {
  description = "The Address Space of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.address_space
}

output "dns_servers" {
  description = "The DNS Servers of the Virtual Network"
  value       = data.azurerm_virtual_network.vnet.dns_servers
}

output "subnets" {
  description = "The Subnets module object in the Virtual Network. Contains merged data and managed subnet objects."
  value       = merge(module.subnets, module.subnets_reused)
}

output "subnets_all" {
  description = "The list of name of the subnets that are attached to this virtual network"
  value       = data.azurerm_virtual_network.vnet.subnets
}
