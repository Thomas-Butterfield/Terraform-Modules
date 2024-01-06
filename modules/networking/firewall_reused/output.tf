output "id" {
  description = "The ID of the Azure Firewall data resource"
  value       = data.azurerm_firewall.fw.id
}

output "name" {
  description = "The Name of the Azure Firewall data resource"
  value       = data.azurerm_firewall.fw.name
}

output "ip_configuration" {
  description = "The IP Configuration (Private IP Address) of the Azure Firewall data resource"
  value       = data.azurerm_firewall.fw.ip_configuration
}
