locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{app_insights}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.app_insights
  resource_type   = "azurerm_application_insights"
  name_mask       = try(var.app_insights.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_application_insights" "app_insights" {
  name                                  = module.resource_naming.name_result
  location                              = var.location != null ? var.location : var.global_settings.location
  resource_group_name                   = var.resource_group_name
  application_type                      = try(var.app_insights.application_type, null)
  daily_data_cap_in_gb                  = try(var.app_insights.daily_data_cap_in_gb, null)
  daily_data_cap_notifications_disabled = try(var.app_insights.daily_data_cap_notifications_disabled, null)
  retention_in_days                     = try(var.app_insights.retention_in_days, 90)
  sampling_percentage                   = try(var.app_insights.sampling_percentage, null)
  disable_ip_masking                    = try(var.app_insights.disable_ip_masking, false)
  workspace_id                          = try(var.workspace_id, null)
  local_authentication_disabled         = try(var.app_insights.local_authentication_disabled, false)
  internet_ingestion_enabled            = try(var.app_insights.internet_ingestion_enabled, false)
  internet_query_enabled                = try(var.app_insights.internet_query_enabled, true)
  force_customer_storage_for_profiler   = try(var.app_insights.internet_query_enabled, false)
  tags                                  = local.tags
}
