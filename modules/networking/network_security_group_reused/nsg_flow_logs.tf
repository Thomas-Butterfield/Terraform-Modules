# Give ability to provision an NSG flow log to an existing (data) NSG resource
module "nsg_flows" {
  source   = "./flow_logs"
  for_each = try(var.network_security_group.flow_logs, {})

  resource_id      = data.azurerm_network_security_group.nsg_obj.id
  nsg_name         = data.azurerm_network_security_group.nsg_obj.name
  global_settings  = var.global_settings
  settings         = each.value
  network_watchers = var.network_watchers
  diagnostics      = var.diagnostics
}
