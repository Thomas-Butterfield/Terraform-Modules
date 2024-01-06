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
resource "azurerm_servicebus_subscription_rule" "correlation_filter" {
  name            = module.resource_naming.name_result
  subscription_id = var.servicebus_subscription_id
  action          = try(var.settings.action, null)
  filter_type     = "CorrelationFilter"

  dynamic "correlation_filter" {
    for_each = try(var.settings.correlation_filter, null) != null ? [1] : [0]

    content {
      content_type        = try(var.settings.correlation_filter.content_type, null)
      correlation_id      = try(var.settings.correlation_filter.correlation_id, null)
      label               = try(var.settings.correlation_filter.label, null)
      message_id          = try(var.settings.correlation_filter.message_id, null)
      reply_to            = try(var.settings.correlation_filter.reply_to, null)
      reply_to_session_id = try(var.settings.correlation_filter.reply_to_session_id, null)
      session_id          = try(var.settings.correlation_filter.session_id, null)
      to                  = try(var.settings.correlation_filter.to, null)
      properties          = try(var.settings.correlation_filter.properties, {})
    }
  }
}