locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{rgName}{delimiter}{rgSuffix}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.resource_group
  resource_type   = "azurerm_resource_group"
  name_mask       = try(var.resource_group.naming_convention.name_mask, local.name_mask) # lookup(try(var.resource_group.naming_convention, {}), "name_mask", null) == null ? local.name_mask : lookup(try(var.resource_group.naming_convention, {}), "name_mask", null)
}

resource "azurerm_resource_group" "rg" {
  name     = module.resource_naming.name_result
  location = var.location != null ? var.location : var.global_settings.location
  tags     = local.tags
}