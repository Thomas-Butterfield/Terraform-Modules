module "namespace_auth_rules" {
  source   = "./namespace_auth_rule"
  for_each = try(var.settings.namespace_auth_rules, {})

  global_settings         = var.global_settings
  settings                = each.value
  servicebus_namespace_id = azurerm_servicebus_namespace.namespace.id
}