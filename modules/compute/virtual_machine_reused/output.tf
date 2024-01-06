output "id" {
  description = "The ID of the Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.id
}

output "name" {
  description = "The Name of the Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.name
}

output "identity" {
  description = "The Identity block of the Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.identity
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.private_ip_address
}

output "private_ip_addresses" {
  description = "A list of Private IP Addresses assigned to this Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.private_ip_addresses
}

output "public_ip_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.public_ip_address
}

output "public_ip_addresses" {
  description = "A list of the Public IP Addresses assigned to this Virtual Machine"
  value       = data.azurerm_virtual_machine.vm.public_ip_addresses
}
