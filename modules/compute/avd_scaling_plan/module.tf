locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null), var.tags)
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_desktop_scaling_plan"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_desktop_scaling_plan" "avd" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  time_zone           = var.settings.time_zone
  description         = try(var.settings.description, null)
  friendly_name       = try(var.settings.friendly_name, null)
  exclusion_tag       = try(var.settings.exclusion_tag, null)
  tags                = local.tags

  dynamic "host_pool" {
    for_each = try(var.settings.host_pools, {})

    content {
      hostpool_id          = var.avd_host_pools[host_pool.value.host_pool_key].id
      scaling_plan_enabled = try(host_pool.value.scaling_plan_enabled, true)
    }
  }

  dynamic "schedule" {
    for_each = try(var.settings.schedules, {})

    content {
      name                                 = schedule.value.name
      days_of_week                         = schedule.value.days_of_week
      off_peak_load_balancing_algorithm    = schedule.value.off_peak_load_balancing_algorithm
      off_peak_start_time                  = schedule.value.off_peak_start_time
      peak_load_balancing_algorithm        = schedule.value.peak_load_balancing_algorithm
      peak_start_time                      = schedule.value.peak_start_time
      ramp_down_capacity_threshold_percent = schedule.value.ramp_down_capacity_threshold_percent
      ramp_down_force_logoff_users         = schedule.value.ramp_down_force_logoff_users
      ramp_down_load_balancing_algorithm   = schedule.value.ramp_down_load_balancing_algorithm
      ramp_down_minimum_hosts_percent      = schedule.value.ramp_down_minimum_hosts_percent
      ramp_down_notification_message       = schedule.value.ramp_down_notification_message
      ramp_down_start_time                 = schedule.value.ramp_down_start_time
      ramp_down_stop_hosts_when            = schedule.value.ramp_down_stop_hosts_when
      ramp_down_wait_time_minutes          = schedule.value.ramp_down_wait_time_minutes
      ramp_up_load_balancing_algorithm     = schedule.value.ramp_up_load_balancing_algorithm
      ramp_up_start_time                   = schedule.value.ramp_up_start_time
      ramp_up_capacity_threshold_percent   = try(schedule.value.ramp_up_capacity_threshold_percent, null)
      ramp_up_minimum_hosts_percent        = try(schedule.value.ramp_up_minimum_hosts_percent, null)
    }
  }

}
