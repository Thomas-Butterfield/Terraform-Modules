locals {
  tags = merge(var.global_settings.tags, var.tags, try(var.virtual_wan.tags, null))
}

data "azurerm_virtual_wan" "vwan" {
  name                = var.virtual_wan.name
  resource_group_name = var.virtual_wan.rg_name
  provider            = azurerm.vhub_provider
}

module "hubs_reused" {
  source = "./virtual_hub"
  providers = {
    azurerm               = azurerm
    azurerm.vhub_provider = azurerm.vhub_provider
  }
  for_each = {
    for key, value in try(var.virtual_wan.virtual_hubs, {}) : key => value
    if try(value.reuse, false) == true
  }

  global_settings     = var.global_settings
  public_ip_addresses = var.public_ip_addresses
  resource_group_name = var.resource_group_name
  tags                = merge(try(each.value.tags, null), local.tags)
  virtual_hub         = each.value
  vwan_id             = data.azurerm_virtual_wan.vwan.id
  virtual_networks    = var.virtual_networks
}

module "hubs" {
  source = "../virtual_wan/virtual_hub"
  # providers = {
  #   azurerm               = azurerm
  #   azurerm.vhub_provider = azurerm.vhub_provider
  # }
  for_each = {
    for key, value in try(var.virtual_wan.virtual_hubs, {}) : key => value
    if try(value.reuse, false) == false
  }

  global_settings     = var.global_settings
  public_ip_addresses = var.public_ip_addresses
  resource_group_name = var.resource_group_name
  tags                = merge(try(each.value.tags, null), local.tags)
  virtual_hub         = each.value
  vwan_id             = data.azurerm_virtual_wan.vwan.id
  virtual_networks    = var.virtual_networks
}
