locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{name}{delimiter}{publicip_prefix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.public_ip_prefix
  resource_type   = "azurerm_public_ip_prefix"
  name_mask       = try(var.public_ip_prefix.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_public_ip_prefix" "pip" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  prefix_length       = var.public_ip_prefix.prefix_length
  sku                 = try(var.public_ip_prefix.sku, "Standard")
  zones               = try(var.public_ip_prefix.zones, null)
  tags                = local.tags
}
