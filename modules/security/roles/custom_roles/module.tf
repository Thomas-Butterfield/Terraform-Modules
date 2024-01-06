locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_role_definition"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_role_definition" "custom_role" {

  name               = var.settings.name
  role_definition_id = try(var.settings.role_definition_id, null)
  scope              = lookup(var.settings, "scope", var.subscription_primary)
  description        = try(var.settings.description, null)

  permissions {
    actions          = lookup(var.settings.permissions, "actions", [])
    not_actions      = lookup(var.settings.permissions, "notActions", [])
    data_actions     = lookup(var.settings.permissions, "dataActions", [])
    not_data_actions = lookup(var.settings.permissions, "notDataActions", [])
  }

  # As recommended by the provider, we're assigning the `scope` object_id as the first
  # entry for `assignable_scopes`
  # Also, the distinct function will avoid duplicating entries
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition#scope
  assignable_scopes = distinct(concat([lookup(var.settings, "scope", var.subscription_primary)], var.assignable_scopes))

}