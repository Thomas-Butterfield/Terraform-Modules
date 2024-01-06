
locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_managed_database"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_managed_database" "sql_mi_db" {
  name = module.resource_naming.name_result
  managed_instance_id = coalesce(
    try(var.settings.managed_instance_id, null),
    try(var.mssql_managed_instances[var.settings.sql_mi_key].id, null)
  )

}
