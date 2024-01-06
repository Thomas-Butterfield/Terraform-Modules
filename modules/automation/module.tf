
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{automationacct}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.automation_account
  resource_type   = "azurerm_automation_account"
  name_mask       = try(var.automation_account.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_automation_account" "auto_account" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  sku_name = var.sku_name
}
