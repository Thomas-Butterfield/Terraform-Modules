locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lock}{delimiter}{postfix}"
}

module "resource_naming" {
  source          = "../../resource_naming"
  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_management_lock"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_management_lock" "lock" {
  name       = module.resource_naming.name_result
  scope      = var.scope_id
  lock_level = try(var.settings.lock_level, "CanNotDelete")
  notes      = try(var.settings.notes, null)
}