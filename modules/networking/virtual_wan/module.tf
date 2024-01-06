locals {
  tags      = merge(var.global_settings.tags, var.tags, try(var.virtual_wan.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vwan}"
}

module "resource_naming_vwan" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.virtual_wan
  resource_type   = "azurerm_virtual_wan"
  name_mask       = try(var.virtual_wan.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_wan" "vwan" {
  name                = module.resource_naming_vwan.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  tags                = local.tags

  type                              = try(var.virtual_wan.type, "Standard")
  disable_vpn_encryption            = try(var.virtual_wan.disable_vpn_encryption, false)
  allow_branch_to_branch_traffic    = try(var.virtual_wan.allow_branch_to_branch_traffic, true)
  office365_local_breakout_category = try(var.virtual_wan.office365_local_breakout_category, "None")
}

module "hubs" {
  source   = "./virtual_hub"
  for_each = try(var.virtual_wan.virtual_hubs, {})

  global_settings     = var.global_settings
  location            = var.location
  public_ip_addresses = var.public_ip_addresses
  resource_group_name = var.resource_group_name
  tags                = merge(try(each.value.tags, null), local.tags)
  virtual_hub         = each.value
  vwan_id             = azurerm_virtual_wan.vwan.id
  virtual_networks    = var.virtual_networks
}
