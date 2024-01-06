
locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_route_server_bgp_connection"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_route_server_bgp_connection" "rs" {
  name            = module.resource_naming.name_result
  route_server_id = var.route_server_id
  peer_asn        = try(var.settings.peer_asn, null)
  peer_ip         = try(var.settings.peer_ip, null)
}
