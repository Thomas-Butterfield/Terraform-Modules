locals {
  tags               = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask_location = lower(var.location != null ? var.location : var.global_settings.location)
  name_mask          = "{networkwatcher}_${local.name_mask_location}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_network_watcher"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_network_watcher" "netwatcher" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}
