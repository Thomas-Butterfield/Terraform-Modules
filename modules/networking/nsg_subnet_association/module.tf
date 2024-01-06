
resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association" {
  for_each = {
    for key, value in try(var.virtual_network_settings.subnets, {}) : key => value
    if try(value.nsg_key, null) != null && try(value.enabled, false) != false
  }

  subnet_id                 = var.virtual_network.subnets[each.key].id
  network_security_group_id = var.network_security_groups[each.value.nsg_key].id
}
