
locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_virtual_network_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_virtual_network_rule" "mssql" {
  name      = module.resource_naming.name_result
  server_id = var.mssql_server_id
  subnet_id = coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  )
  ignore_missing_vnet_service_endpoint = try(var.settings.ignore_missing_vnet_service_endpoint, null)
}
