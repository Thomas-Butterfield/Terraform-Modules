locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_topic_authorization_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_topic_authorization_rule" "topic_auth_rule" {
  name     = module.resource_naming.name_result
  topic_id = var.servicebus_topic_id
  listen   = try(var.settings.listen, false)
  send     = try(var.settings.send, false)
  manage   = try(var.settings.manage, false)
}
