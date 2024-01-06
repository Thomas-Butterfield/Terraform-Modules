
output "id" {
  description = "The ID of the Virtual Hub Connection"
  value       = var.virtual_hub_as_data ? azurerm_virtual_hub_connection.vhubconn_data[0].id : azurerm_virtual_hub_connection.vhubconn[0].id
}

output "name" {
  description = "The Name of the Virtual Hub Connection"
  value       = var.virtual_hub_as_data ? azurerm_virtual_hub_connection.vhubconn_data[0].name : azurerm_virtual_hub_connection.vhubconn[0].name
}
