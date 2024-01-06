output "id" {
  description = "The ID of the IP Group"
  value       = azurerm_ip_group.ip_group.id
}
output "name" {
  description = "The Name of the IP Group"
  value       = azurerm_ip_group.ip_group.name
}
output "cidrs" {
  description = "The CIDRs of the IP Group"
  value       = local.cidrs
}
