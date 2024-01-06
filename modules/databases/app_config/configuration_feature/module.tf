
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_app_configuration_feature"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_app_configuration_feature" "config" {
  name                    = module.resource_naming.name_result
  configuration_store_id  = var.configuration_store_id
  description             = try(var.settings.description, null)
  label                   = try(var.settings.label, null)
  enabled                 = try(var.settings.enabled, false)
  locked                  = try(var.settings.locked, null)
  percentage_filter_value = try(var.settings.percentage_filter_value, false)
  tags                    = local.tags

  dynamic "targeting_filter" {
    for_each = lookup(var.settings, "targeting_filter", {}) == {} ? [] : [1]

    content {
      default_rollout_percentage = try(var.settings.targeting_filter.default_rollout_percentage, null)
      users                      = try(var.settings.targeting_filter.users, null)

      dynamic "groups" {
        for_each = try(var.settings.targeting_filter.groups, {})

        content {
          name               = try(groups.value.name, null)
          rollout_percentage = try(groups.value.rollout_percentage, null)
        }
      }

    }
  }

  dynamic "timewindow_filter" {
    for_each = lookup(var.settings, "timewindow_filter", {}) == {} ? [] : [1]

    content {
      start = try(var.settings.timewindow_filter.start, null)
      end   = try(var.settings.timewindow_filter.end, null)
    }
  }

}
