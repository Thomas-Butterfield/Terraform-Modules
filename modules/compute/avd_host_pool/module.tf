locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null), var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_desktop_host_pool"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_desktop_host_pool" "avdpool" {
  location                         = var.location != null ? var.location : var.global_settings.location
  resource_group_name              = var.resource_group_name
  name                             = module.resource_naming.name_result
  friendly_name                    = try(var.settings.friendly_name, null)
  description                      = try(var.settings.description, null)
  validate_environment             = try(var.settings.validate_environment, null)
  type                             = var.settings.type
  maximum_sessions_allowed         = try(var.settings.maximum_sessions_allowed, null)
  load_balancer_type               = try(var.settings.load_balancer_type, null)
  personal_desktop_assignment_type = try(var.settings.personal_desktop_assignment_type, null)
  preferred_app_group_type         = try(var.settings.preferred_app_group_type, null)
  custom_rdp_properties            = try(var.settings.custom_rdp_properties, null)
  start_vm_on_connect              = try(var.settings.start_vm_on_connect, null)
  tags                             = local.tags

  dynamic "scheduled_agent_updates" {
    for_each = try(var.settings.scheduled_agent_updates, {})
    content {
      enabled                   = try(scheduled_agent_updates.value.enabled, false)
      timezone                  = try(scheduled_agent_updates.value.timezone, "UTC")
      use_session_host_timezone = try(scheduled_agent_updates.value.use_session_host_timezone, false)

      dynamic "schedule" {
        for_each = try(scheduled_agent_updates.value.schedule, {})
        content {
          day_of_week = schedule.value.day_of_week
          hour_of_day = schedule.value.hour_of_day
        }
      }
    }
  }
}

resource "time_rotating" "avd_registration_expiration" {
  count = try(var.settings.registration_info, null) == null || try(var.settings.registration_info.expiration_date, null) != null ? 0 : 1

  # Must be between 1 hour and 30 days
  # At least one rotation_ argument must be configured
  rotation_days    = try(var.settings.registration_info.rotation_days, null)
  rotation_hours   = try(var.settings.registration_info.rotation_hours, null)
  rotation_minutes = try(var.settings.registration_info.rotation_minutes, null)
  rotation_months  = try(var.settings.registration_info.rotation_months, null)
  rotation_years   = try(var.settings.registration_info.rotation_years, null)
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registration_info" {
  count = try(var.settings.registration_info, null) == null ? 0 : 1

  hostpool_id     = azurerm_virtual_desktop_host_pool.avdpool.id
  expiration_date = try(var.settings.registration_info.expiration_date, time_rotating.avd_registration_expiration[0].rotation_rfc3339)
}
