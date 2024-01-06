locals {
  tags         = merge(var.global_settings.tags, try(var.settings.tags, null))
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressrouteport}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_express_route_port"
  name_mask       = try(var.settings.naming_convention.name_mask, local.er_name_mask)
}

resource "azurerm_express_route_port" "er_port" {

  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  tags                = local.tags
  bandwidth_in_gbps   = var.settings.bandwidth_in_gbps
  encapsulation       = var.settings.encapsulation # Possible values are: Dot1Q, QinQ
  peering_location    = var.settings.peering_location
}
