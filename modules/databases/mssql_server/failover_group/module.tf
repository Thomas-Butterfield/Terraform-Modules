
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"

  databases = [
    for key, value in var.settings.databases : var.databases[value.database_key].id
  ]
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_failover_group"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_failover_group" "failover_group" {
  name                                      = module.resource_naming.name_result
  server_id                                 = var.primary_mssql_server_id
  databases                                 = local.databases
  readonly_endpoint_failover_policy_enabled = try(var.settings.readonly_endpoint_failover_policy_enabled, false)
  tags                                      = local.tags

  partner_server {
    id = var.secondary_mssql_server_id
  }

  read_write_endpoint_failover_policy {
    mode          = var.settings.read_write_endpoint_failover_policy.mode
    grace_minutes = var.settings.read_write_endpoint_failover_policy.mode == "Automatic" ? var.settings.read_write_endpoint_failover_policy.grace_minutes : null
  }

}