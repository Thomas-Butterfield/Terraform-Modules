
resource "azurerm_subnet_route_table_association" "rt_vnet_association" {
  for_each = {
    for key, value in try(var.virtual_network_settings.subnets, {}) : key => value
    if try(value.route_table_key, null) != null && try(value.enabled, false) != false
  }

  subnet_id      = var.virtual_network.subnets[each.key].id
  route_table_id = var.route_tables[each.value.route_table_key].id
}
