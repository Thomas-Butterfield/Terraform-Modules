locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressrouteport}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_route_filter"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_route_filter" "rt_filter" {

  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  tags                = local.tags

  dynamic "rule" {
    for_each = try(var.settings.rule, null) == null ? [] : [1]

    content {
      name        = var.settings.rule.name
      access      = try(var.settings.rule.access, "Allow")
      rule_type   = try(var.settings.rule.rule_type, "Community")
      communities = var.settings.rule.communities
    }
  }

}
