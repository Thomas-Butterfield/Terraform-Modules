module "correlation_filter_rules" {
  source = "./subscription_rule/correlation_filter"
  for_each = {
    for key, value in try(var.settings.subscription_rules, {}) : key => value
    if try(value.filter_type, null) == "CorrelationFilter"
  }

  global_settings            = var.global_settings
  settings                   = each.value
  servicebus_subscription_id = azurerm_servicebus_subscription.subscription.id
}

module "sql_filter_rules" {
  source = "./subscription_rule/sql_filter"
  for_each = {
    for key, value in try(var.settings.subscription_rules, {}) : key => value
    if try(value.filter_type, null) == "SqlFilter"
  }

  global_settings            = var.global_settings
  settings                   = each.value
  servicebus_subscription_id = azurerm_servicebus_subscription.subscription.id
}
