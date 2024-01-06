
module "nsg_flows" {
  source = "./flow_logs"
  for_each = {
    for key, value in try(var.network_security_group.flow_logs, {}) : key => value
    if try(value.enabled, false) == true
  }

  location         = var.location
  resource_id      = azurerm_network_security_group.nsg_obj.id
  nsg_name         = azurerm_network_security_group.nsg_obj.name
  global_settings  = var.global_settings
  settings         = each.value
  network_watchers = var.network_watchers
  diagnostics      = var.diagnostics
}
