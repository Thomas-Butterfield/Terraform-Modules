
locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_firewall_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_firewall_rule" "mssql" {
  name             = module.resource_naming.name_result
  server_id        = var.mssql_server_id
  start_ip_address = var.settings.start_ip_address
  end_ip_address   = var.settings.end_ip_address
}
