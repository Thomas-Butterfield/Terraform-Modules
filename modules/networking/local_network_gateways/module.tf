locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lng}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_local_network_gateway"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_local_network_gateway" "lngw" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  address_space       = var.settings.address_space
  gateway_address     = try(var.settings.gateway_address, null)
  gateway_fqdn        = try(var.settings.gateway_fqdn, null)

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.peering_address
      peer_weight         = try(bgp_settings.value.peer_weight, null)
    }
  }
}