locals {
  name_mask = "{referenced_name}{delimiter}to{delimiter}{referenced_name_1}"

  #The name can be up to 80 characters long. It must begin with a word character, and it must end with a word character or with '_'. 
  #The name may contain word characters or '.', '-', '_'."

  #Therefore, we are going to attempt our best to strip out the address prefix to limit the length!
  clean_vnet_name        = element(split("_", var.virtual_network_name), 0)
  clean_remote_vnet_name = element(split("_", var.remote_virtual_network_name), 0)
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings   = var.global_settings
  settings          = var.vnet_peering
  resource_type     = "azurerm_virtual_network_peering"
  referenced_name   = local.clean_vnet_name
  referenced_name_1 = local.clean_remote_vnet_name
  name_mask         = try(var.vnet_peering.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_network_peering" "vnet-peering" {
  name                         = module.resource_naming.name_result
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = try(var.vnet_peering.allow_virtual_network_access, true)
  allow_gateway_transit        = try(var.vnet_peering.allow_gateway_transit, false)
  allow_forwarded_traffic      = try(var.vnet_peering.allow_forwarded_traffic, true)
  use_remote_gateways          = try(var.vnet_peering.use_remote_gateways, false)
}
