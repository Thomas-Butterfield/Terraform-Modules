locals {
  tags      = merge(var.global_settings.tags, var.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{route_server}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_route_server"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_route_server" "rs" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  subnet_id = coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  )
  public_ip_address_id             = coalesce(try(var.settings.public_ip_address_id, null), try(var.public_ip_addresses[var.settings.public_ip_key].id, null))
  branch_to_branch_traffic_enabled = try(var.settings.branch_to_branch_traffic_enabled, null)
  tags                             = local.tags
}
