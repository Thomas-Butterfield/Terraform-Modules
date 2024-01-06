data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network.name
  resource_group_name = var.virtual_network.rg_name
}

# ==================================================================================
# To make backward compatibility smoother, we will set "reuse" as default true
# This means the module will default to data lookup and only attempt to provision
# new subnets if the reuse flag is present and set to false
# ==================================================================================

module "subnets_reused" {
  source = "./subnet_reused"

  for_each = {
    for key, value in try(var.virtual_network.subnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, true) == true
  }

  subnet              = each.value
  vnet_name           = var.virtual_network.name
  resource_group_name = var.virtual_network.rg_name
}

module "subnets" {
  source = "./subnet"

  for_each = {
    for key, value in try(var.virtual_network.subnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, true) == false
  }

  name                 = each.value.name
  global_settings      = var.global_settings
  subnet               = each.value
  resource_group_name  = var.virtual_network.rg_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = lookup(each.value, "address_prefixes", [])
  # service_endpoints    = lookup(each.value, "service_endpoints", ["Microsoft.KeyVault", "Microsoft.Storage"])
  # Adjusting custom subnets to not enable service_endpoints KV and SA by default
  service_endpoints = lookup(each.value, "service_endpoints", [])
  ## If left to true, we will not be able to create private endpoints in the given subnet!
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", true)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", true)
}
