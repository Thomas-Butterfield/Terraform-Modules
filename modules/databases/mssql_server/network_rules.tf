module "network_rules" {
  source   = "./network_rule"
  for_each = try(var.settings.network_rules, {})

  global_settings  = var.global_settings
  settings         = each.value
  mssql_server_id  = azurerm_mssql_server.mssql.id
  virtual_networks = var.virtual_networks
}