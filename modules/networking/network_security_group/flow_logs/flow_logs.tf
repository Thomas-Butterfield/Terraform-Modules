locals {
  name_mask = "{name}{delimiter}{nsgflowlogs}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_network_watcher_flow_log"
  name            = try(var.settings.name, var.nsg_name) # Use nsg_name as the default
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_network_watcher_flow_log" "flow" {
  # count = try(var.diagnostics, {}) != {} ? 1 : 0

  name     = module.resource_naming.name_result
  location = var.location != null ? var.location : var.global_settings.location

  network_watcher_name = try(
    var.network_watchers[var.settings.network_watcher_key].name,
    format("NetworkWatcher_%s", var.global_settings.location)
  )

  resource_group_name = try(
    var.network_watchers[var.settings.network_watcher_key].resource_group_name,
    "NetworkWatcherRG"
  )

  storage_account_id = try(var.diagnostics.storage_accounts[var.settings.storage_account.storage_account_key].id, var.diagnostics.diagnostics_destinations.storage[var.settings.storage_account.storage_account_destination][var.global_settings.location].storage_account_resource_id, var.diagnostics.storage_accounts[var.diagnostics.diagnostics_destinations.storage[var.settings.storage_account.storage_account_destination][var.global_settings.location].storage_account_key].id)

  version                   = try(var.settings.version, 2)
  enabled                   = try(var.settings.enabled, false)
  network_security_group_id = var.resource_id

  retention_policy {
    enabled = try(var.settings.storage_account.retention.enabled, true)
    days    = try(var.settings.storage_account.retention.days, 10)
  }

  dynamic "traffic_analytics" {
    for_each = try(var.settings.traffic_analytics, {}) != {} ? [1] : []
    content {
      enabled               = var.settings.traffic_analytics.enabled
      interval_in_minutes   = try(var.settings.traffic_analytics.interval_in_minutes, null)
      workspace_id          = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].workspace_id
      workspace_region      = var.global_settings.location
      workspace_resource_id = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].id
    }
  }
}
