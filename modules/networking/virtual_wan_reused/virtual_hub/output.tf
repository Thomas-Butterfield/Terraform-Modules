output "id" {
  description = "The ID of the Data Virtual Hub"
  value       = data.azurerm_virtual_hub.vwan_hub.id
}
output "name" {
  description = "The Name of the Data Virtual Hub"
  value       = data.azurerm_virtual_hub.vwan_hub.name
}
