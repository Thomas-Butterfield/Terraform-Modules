## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit

locals {
  tags         = merge(var.global_settings.tags, try(var.settings.tags, null))
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuit}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_express_route_circuit"
  name_mask       = try(var.settings.naming_convention.name_mask, local.er_name_mask)
}

resource "azurerm_express_route_circuit" "circuit" {

  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  tags                = local.tags

  ## NOTE
  ## The service_provider_name, the peering_location and the bandwidth_in_mbps should be set together 
  ## and they conflict with express_route_port_id and bandwidth_in_gbps
  service_provider_name = try(var.settings.service_provider_name, null) # Old default "Equinix"
  peering_location      = try(var.settings.peering_location, null)      # Old default "Washington DC"
  bandwidth_in_mbps     = try(var.settings.bandwidth_in_mbps, null)     # Old default 500

  ## NOTE
  ## The express_route_port_id and the bandwidth_in_gbps should be set together and they 
  ## conflict with service_provider_name, peering_location and bandwidth_in_mbps
  express_route_port_id = try(var.express_route_port_id, var.settings.express_route_port_id, null)
  bandwidth_in_gbps     = try(var.settings.bandwidth_in_gbps, null)

  sku {
    tier   = try(var.settings.tier, "Premium")
    family = try(var.settings.family, "MeteredData")
  }
}
