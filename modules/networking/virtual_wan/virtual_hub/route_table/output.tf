output "id" {
  description = "The ID of the Virtual Hub Route Table"
  value       = [for rtTable in azurerm_virtual_hub_route_table.vhub-routetable : rtTable.id]
}
