locals {
  tags                     = merge(var.global_settings.tags, var.tags)
  naming_combined_settings = var.managed_identity
  # Postfix not needed as we are appending the key
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = local.naming_combined_settings
  resource_type   = "azurerm_user_assigned_identity"
  name_mask       = try(var.managed_identity.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_user_assigned_identity" "msi" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  lifecycle {
    ignore_changes = [
      location, resource_group_name
    ]
  }
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azurerm_user_assigned_identity.msi
  ]

  create_duration = "30s"
}
