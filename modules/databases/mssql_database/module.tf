
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_database"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_database" "mssql_db" {
  name = module.resource_naming.name_result
  server_id = coalesce(
    try(var.settings.server_id, null),
    try(var.mssql_servers[var.settings.mssql_server_key].id, null)
  )
  auto_pause_delay_in_minutes = try(var.settings.auto_pause_delay_in_minutes, null)
  create_mode                 = try(var.settings.create_mode, null)
  creation_source_database_id = try(var.settings.creation_source_database_id, null)
  collation                   = try(var.settings.collation, null)
  elastic_pool_id = coalesce(
    try(var.settings.elastic_pool_id, null),
    try(var.mssql_elastic_pools[var.settings.mssql_elastic_pool_key].id, null)
  )
  geo_backup_enabled                  = try(var.settings.geo_backup_enabled, null)
  maintenance_configuration_name      = try(var.settings.maintenance_configuration_name, null)
  ledger_enabled                      = try(var.settings.ledger_enabled, false)
  license_type                        = try(var.settings.license_type, null)
  max_size_gb                         = try(var.settings.max_size_gb, null)
  min_capacity                        = try(var.settings.min_capacity, null)
  restore_point_in_time               = try(var.settings.restore_point_in_time, null)
  recover_database_id                 = try(var.settings.recover_database_id, null)
  restore_dropped_database_id         = try(var.settings.restore_dropped_database_id, null)
  read_replica_count                  = try(var.settings.read_replica_count, null)
  read_scale                          = try(var.settings.read_scale, null)
  sample_name                         = try(var.settings.sample_name, null)
  sku_name                            = try(var.settings.sku_name, null)
  storage_account_type                = try(var.settings.storage_account_type, "Geo")
  transparent_data_encryption_enabled = try(var.settings.transparent_data_encryption_enabled, true)
  zone_redundant                      = try(var.settings.zone_redundant, null)
  tags                                = local.tags

  dynamic "import" {
    for_each = try(var.settings.import, {}) == {} ? [] : [1]

    content {
      storage_uri                  = try(var.settings.import.storage_uri, null)
      storage_key                  = try(var.settings.import.storage_key, null)
      storage_key_type             = try(var.settings.import.storage_key_type, null)
      administrator_login          = try(var.settings.import.administrator_login, null)
      administrator_login_password = try(var.settings.import.administrator_login_password, null)
      authentication_type          = try(var.settings.import.authentication_type, null)
      storage_account_id           = try(var.settings.import.storage_account_id, null)
    }
  }

  dynamic "threat_detection_policy" {
    for_each = try(var.settings.threat_detection_policy, {}) == {} ? [] : [1]

    content {
      state                      = try(var.settings.threat_detection_policy.state, null)
      disabled_alerts            = try(var.settings.threat_detection_policy.disabled_alerts, null)
      email_account_admins       = try(var.settings.threat_detection_policy.email_account_admins, null)
      email_addresses            = try(var.settings.threat_detection_policy.email_addresses, null)
      retention_days             = try(var.settings.threat_detection_policy.retention_days, null)
      storage_account_access_key = try(var.settings.threat_detection_policy.storage_account_access_key, null)
      storage_endpoint           = try(var.settings.threat_detection_policy.storage_endpoint, null)
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = try(var.settings.long_term_retention_policy, {}) == {} ? [] : [1]

    content {
      weekly_retention  = try(var.settings.long_term_retention_policy.weekly_retention, null)
      monthly_retention = try(var.settings.long_term_retention_policy.monthly_retention, null)
      yearly_retention  = try(var.settings.long_term_retention_policy.yearly_retention, null)
      week_of_year      = try(var.settings.long_term_retention_policy.week_of_year, null)
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = try(var.settings.short_term_retention_policy, {}) == {} ? [] : [1]

    content {
      retention_days           = try(var.settings.short_term_retention_policy.retention_days, null)
      backup_interval_in_hours = try(var.settings.short_term_retention_policy.backup_interval_in_hours, null)
    }
  }

}
