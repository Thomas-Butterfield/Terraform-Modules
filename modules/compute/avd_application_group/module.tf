locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null), var.tags)
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_desktop_application_group"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_desktop_application_group" "dag" {
  name                         = module.resource_naming.name_result
  location                     = var.location != null ? var.location : var.global_settings.location
  resource_group_name          = var.resource_group_name
  friendly_name                = try(var.settings.friendly_name, null)
  default_desktop_display_name = try(var.settings.default_desktop_display_name, null)
  description                  = try(var.settings.description, null)
  type                         = var.settings.type
  host_pool_id                 = var.host_pool_id
  tags                         = local.tags
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "dag" {
  workspace_id         = var.workspace_id
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
}
