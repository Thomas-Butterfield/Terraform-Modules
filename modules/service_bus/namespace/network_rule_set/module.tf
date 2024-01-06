resource "azurerm_servicebus_namespace_network_rule_set" "rule_set" {
  namespace_id                  = var.servicebus_namespace_id
  default_action                = try(var.settings.default_action, "Deny")
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  trusted_services_allowed      = try(var.settings.trusted_services_allowed, null)
  ip_rules                      = var.settings.ip_rules

  dynamic "network_rules" {
    for_each = try(var.settings.network_rules, {})
    content {
      subnet_id                            = try(var.virtual_networks[network_rules.value.vnet_key].subnets[network_rules.value.subnet_key].id, null)
      ignore_missing_vnet_service_endpoint = try(network_rules.value.ignore_missing_vnet_service_endpoint, false)
    }
  }
}
