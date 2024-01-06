locals {
  tags         = merge(var.global_settings.tags, try(var.settings.tags, null))
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuitconn}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_express_route_circuit_connection"
  name_mask       = try(var.settings.naming_convention.name_mask, local.er_name_mask)
}

resource "azurerm_express_route_circuit_connection" "er_circuit_conn" {

  name                = module.resource_naming.name_result
  peering_id          = var.peering_id
  peer_peering_id     = var.peer_peering_id
  address_prefix_ipv4 = var.settings.address_prefix_ipv4

  # Optional
  authorization_key   = try(var.settings.authorization_key, null)
  address_prefix_ipv6 = try(var.settings.address_prefix_ipv6, null)
}
