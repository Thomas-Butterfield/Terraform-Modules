locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{sbus_ns_auth_rule}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_namespace_authorization_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_namespace_authorization_rule" "namespace_auth_rule" {
  name         = module.resource_naming.name_result
  namespace_id = var.servicebus_namespace_id
  listen       = try(var.settings.listen, false)
  send         = try(var.settings.send, false)
  manage       = try(var.settings.manage, false)
}
