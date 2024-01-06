output "id" {
  description = "The ID of the Azure Firewall"
  value       = azurerm_firewall.fw.id
}

output "name" {
  description = "The Name of the Azure Firewall"
  value       = azurerm_firewall.fw.name
}

output "ip_configuration" {
  description = "The IP Configuration (Private IP Address) of the Azure Firewall"
  value       = azurerm_firewall.fw.ip_configuration
}

output "virtual_hub" {
  description = "The Virtual Hub resource object if Secured Hub"
  value       = azurerm_firewall.fw.virtual_hub
}
