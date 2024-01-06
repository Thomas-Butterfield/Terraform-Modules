locals {
  tags         = merge(var.global_settings.tags, try(var.settings.tags, null))
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressrouteconnection}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_express_route_connection"
  name_mask       = try(var.settings.naming_convention.name_mask, local.er_name_mask)
}

resource "azurerm_express_route_connection" "er_conn" {

  name                             = module.resource_naming.name_result
  express_route_gateway_id         = var.express_route_gateway_id
  express_route_circuit_peering_id = var.express_route_circuit_peering_id

  # Optional
  authorization_key        = try(var.settings.authorization_key, null)
  enable_internet_security = try(var.settings.enable_internet_security, null)
  routing_weight           = try(var.settings.routing_weight, null)

  ##TODO ROUTING block
  ##https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_connection#routing
  #dynamic "routing" {
  #for_each = can(var.settings.routing) ? [1] : []

}
