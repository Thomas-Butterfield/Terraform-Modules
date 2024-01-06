
# skus
# B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1
# Isolated SKUs (I1, I2, I3, I1v2, I2v2, and I3v2) can only be used with App Service Environments
# Elastic and Consumption SKUs (Y1, EP1, EP2, and EP3) are for use with Function Apps

locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{app_service_plan}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_app_service_plan"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_service_plan" "asp" {
  name                         = module.resource_naming.name_result
  location                     = var.location != null ? var.location : var.global_settings.location
  resource_group_name          = var.resource_group_name
  os_type                      = var.settings.os_type # Windows, Linux, and WindowsContainer
  sku_name                     = var.settings.sku_name
  app_service_environment_id   = var.app_service_environment_id
  maximum_elastic_worker_count = try(var.settings.maximum_elastic_worker_count, null)
  worker_count                 = try(var.settings.worker_count, null)
  per_site_scaling_enabled     = try(var.settings.per_site_scaling_enabled, false)
  zone_balancing_enabled       = try(var.settings.zone_balancing_enabled, false)
  tags                         = local.tags

  timeouts {
    create = "5h"
    update = "5h"
  }
}
