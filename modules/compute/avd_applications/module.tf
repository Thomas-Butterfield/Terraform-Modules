locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_desktop_application"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_desktop_application" "da" {
  name                         = module.resource_naming.name_result
  application_group_id         = var.application_group_id
  friendly_name                = try(var.settings.friendly_name, null)
  description                  = try(var.settings.description, null)
  path                         = var.settings.path
  command_line_argument_policy = var.settings.command_line_argument_policy
  command_line_arguments       = try(var.settings.command_line_arguments, null)
  show_in_portal               = try(var.settings.show_in_portal, null)
  icon_path                    = try(var.settings.icon_path, null)
  icon_index                   = try(var.settings.icon_index, null)
}
