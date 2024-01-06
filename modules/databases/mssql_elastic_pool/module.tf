
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{referenced_name}{delimiter}{mssql_server_elastic_pool}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  referenced_name = var.mssql_servers[var.settings.mssql_server_key].name
  resource_type   = "azurerm_mssql_elasticpool"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_elasticpool" "elasticpool" {
  name                           = module.resource_naming.name_result
  location                       = var.location != null ? var.location : var.global_settings.location
  resource_group_name            = var.resource_group_name
  server_name                    = var.mssql_servers[var.settings.mssql_server_key].name
  maintenance_configuration_name = try(var.settings.maintenance_configuration_name, null)
  max_size_gb                    = try(var.settings.max_size_gb, null)
  max_size_bytes                 = try(var.settings.max_size_bytes, null)
  zone_redundant                 = try(var.settings.zone_redundant, null)
  license_type                   = try(var.settings.license_type, null)
  tags                           = local.tags

  sku {
    name     = var.settings.sku.name
    tier     = var.settings.sku.tier
    capacity = var.settings.sku.capacity
    family   = try(var.settings.sku.family, null)
  }

  per_database_settings {
    min_capacity = var.settings.per_database_settings.min_capacity
    max_capacity = var.settings.per_database_settings.max_capacity
  }
}