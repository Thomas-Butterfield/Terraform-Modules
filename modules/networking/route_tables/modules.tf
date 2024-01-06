locals {
  tags      = merge(var.global_settings.tags, var.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{routetable}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_route_table"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_route_table" "rt" {
  name                          = module.resource_naming.name_result
  resource_group_name           = var.resource_group_name
  location                      = var.location != null ? var.location : var.global_settings.location
  disable_bgp_route_propagation = try(var.settings.disable_bgp_route_propagation, false)
  tags                          = local.tags

  dynamic "route" {
    for_each = try(var.settings.routes, {})
    content {
      name           = route.value.name
      address_prefix = route.value.address_prefix
      # next_hop_type = VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(lower(route.value.next_hop_type), null) == "virtualappliance" ? try(route.value.next_hop_in_ip_address, var.firewall_ip_address) : null
    }
  }
}
