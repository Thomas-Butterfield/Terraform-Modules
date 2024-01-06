locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null), var.tags)
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_desktop_workspace"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_desktop_workspace" "avdws" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name

  friendly_name                 = try(var.settings.friendly_name, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  description                   = try(var.settings.description, null)
  tags                          = local.tags
}
