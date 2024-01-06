module "network_rule_sets" {
  source   = "./network_rule_set"
  for_each = try(var.settings.network_rule_sets, {})

  global_settings         = var.global_settings
  settings                = each.value
  servicebus_namespace_id = azurerm_servicebus_namespace.namespace.id
  virtual_networks        = var.virtual_networks
}