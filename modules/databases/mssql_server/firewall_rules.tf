module "firewall_rules" {
  source   = "./firewall_rule"
  for_each = try(var.settings.firewall_rules, {})

  global_settings = var.global_settings
  settings        = each.value
  mssql_server_id = azurerm_mssql_server.mssql.id
}