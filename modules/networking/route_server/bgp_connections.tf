module "bgp_connections" {
  source   = "./bgp_connection"
  for_each = try(var.settings.bgp_connections, {})

  global_settings = var.global_settings
  settings        = each.value
  route_server_id = azurerm_route_server.rs.id
}