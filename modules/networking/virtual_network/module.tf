// Creates the networks virtual network, the subnets and associated NSG, with a special section for AzureFirewallSubnet

locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vnet}-{postfix}_{vnet_address_space}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.virtual_network
  resource_type   = "azurerm_virtual_network"
  name_mask       = try(var.virtual_network.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_network" "vnet" {
  name                = module.resource_naming.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network.address_space
  dns_servers         = try(var.virtual_network.dns_servers, []) # NOTE: Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it.
  tags                = local.tags
}

module "subnets" {
  source = "./subnet"

  for_each = {
    for key, value in try(var.virtual_network.subnets, {}) : key => value
    if try(value.enabled, false) == true
  }
  name                 = each.value.name
  global_settings      = var.global_settings
  subnet               = each.value
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = lookup(each.value, "address_prefixes", [])
  service_endpoints    = lookup(each.value, "service_endpoints", ["Microsoft.KeyVault", "Microsoft.Storage"])
  ## If left to true, we will not be able to create private endpoints in the given subnet!
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", true)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", true)
}
