
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{app_service_env}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_app_service_environment"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_app_service_environment" "ase" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  tags                = local.tags
  subnet_id = coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  )
  internal_load_balancing_mode = try(var.settings.internal_load_balancing_mode, null)
  pricing_tier                 = try(var.settings.pricing_tier, null)
  front_end_scale_factor       = try(var.settings.front_end_scale_factor, null)
  allowed_user_ip_cidrs        = try(var.settings.allowed_user_ip_cidrs, null)

  dynamic "cluster_setting" {
    for_each = try(var.settings.cluster_settings, {})

    content {
      name  = cluster_setting.value.name
      value = cluster_setting.value.value
    }
  }
}
