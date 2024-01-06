
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

resource "azurerm_app_service_environment_v3" "ase" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  tags                = local.tags
  subnet_id = coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  )
  allow_new_private_endpoint_connections = try(var.settings.allow_new_private_endpoint_connections, true)
  dedicated_host_count                   = try(var.settings.dedicated_host_count, null)
  zone_redundant                         = try(var.settings.zone_redundant, null)
  internal_load_balancing_mode           = try(var.settings.internal_load_balancing_mode, null)

  # If this block is specified it must contain the FrontEndSSLCipherSuiteOrder setting, with the value TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
  dynamic "cluster_setting" {
    for_each = try(var.settings.cluster_settings, {})

    content {
      name  = cluster_setting.value.name
      value = cluster_setting.value.value
    }
  }

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3#tags
  # The underlying API does not currently support changing Tags on this resource. Making changes in the portal for tags will cause Terraform to detect a change that will force a recreation of the ASEV3 unless ignore_changes lifecycle meta-argument is used.
  lifecycle {
    ignore_changes = [
      tags
    ]
  }

}
