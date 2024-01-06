locals {
  er_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{erg}{delimiter}{postfix}"
}

module "resource_naming_erg" {
  source = "../../../resource_naming"
  count  = try(var.virtual_hub.deploy_er, false) ? 1 : 0

  global_settings = var.global_settings
  settings        = var.virtual_hub
  resource_type   = "azurerm_express_route_gateway"
  name_mask       = try(var.virtual_hub.naming_convention.name_mask, local.er_name_mask)
}

## create the ER Gateway
resource "azurerm_express_route_gateway" "er_gateway" {
  count = try(var.virtual_hub.deploy_er, false) ? 1 : 0

  name                = module.resource_naming_erg.0.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub.id
  scale_units         = var.virtual_hub.er_config.scale_units

  timeouts {
    create = "60m"
    delete = "120m"
  }
}