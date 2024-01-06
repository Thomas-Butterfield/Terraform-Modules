locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_subscription_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

# Arguments "sql_filter" and "correlation_filter" cannot appear at the same time despite setting to null, thus need to split
resource "azurerm_servicebus_subscription_rule" "sql_filter" {
  name            = module.resource_naming.name_result
  subscription_id = var.servicebus_subscription_id
  action          = try(var.settings.action, null)
  filter_type     = "SqlFilter"
  sql_filter      = var.settings.sql_filter
}