locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{ipgroup}{delimiter}{postfix}"

  cidrs = try(var.settings.cidrs, try(var.settings.subnet_keys, []) == [] ? var.vnet.address_space : flatten([
    for key, subnet in var.vnet.subnets : subnet.address_prefixes
    if contains(var.settings.subnet_keys, key)
  ]))

}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_ip_group"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_ip_group" "ip_group" {

  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  cidrs               = local.cidrs
}
