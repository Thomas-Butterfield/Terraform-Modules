locals {
  tags         = merge(var.global_settings.tags, try(var.settings.tags, null))
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuitauth}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_express_route_circuit_authorization"
  name_mask       = try(var.settings.naming_convention.name_mask, local.er_name_mask)
}

resource "azurerm_express_route_circuit_authorization" "er_circuit_auth" {

  name                       = module.resource_naming.name_result
  resource_group_name        = var.resource_group_name
  express_route_circuit_name = var.express_route_circuit_name
}
