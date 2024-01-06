output "id" {
  description = "The ID of the Data Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.id
}

output "name" {
  description = "The Name of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.name
}

output "virtual_hub" {
  description = "The Virtual Hub resource object"
  value       = azurerm_virtual_hub.vwan_hub
}

output "default_route_table_id" {
  description = "The Default Route Table Resource ID of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.default_route_table_id
}

output "er_gateway" {
  description = "The Virtual Network Gateway - Express Route resource object"
  value       = try(var.virtual_hub.deploy_er, false) ? azurerm_express_route_gateway.er_gateway.0 : null
}

output "s2s_gateway" {
  description = "The Virtual Network Gateway - Site 2 Site resource object"
  value       = try(var.virtual_hub.deploy_s2s, false) ? azurerm_vpn_gateway.s2s_gateway.0 : null
}

output "p2s_gateway" {
  description = "The Virtual Network Gateway - Point to Site resource object"
  value       = try(var.virtual_hub.deploy_p2s, false) ? azurerm_point_to_site_vpn_gateway.p2s_gateway.0 : null
}
