locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{loganalytics}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.log_analytics
  resource_type   = "azurerm_log_analytics_workspace"
  name_mask       = try(var.log_analytics.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  sku                 = lookup(var.log_analytics, "sku", "PerGB2018")
  retention_in_days   = lookup(var.log_analytics, "retention_in_days", 90)
  tags                = local.tags
}