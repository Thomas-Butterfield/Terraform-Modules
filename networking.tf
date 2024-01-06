## NSGs
module "network_security_groups" {
  source = "./modules/networking/network_security_group"
  for_each = {
    for key, value in try(local.settings.networking.network_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings        = local.settings
  location               = try(each.value.location, null)
  resource_group_name    = local.resource_groups[each.value.resource_group_key].name
  network_security_group = each.value
  network_watchers       = module.network_watchers
  diagnostics            = local.diagnostics
  tags                   = try(each.value.tags, null)
}

## NSG/Subnet Association
module "nsg_subnet_assoc" {
  source = "./modules/networking/nsg_subnet_association"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  network_security_groups  = module.network_security_groups
  virtual_network_settings = each.value
  virtual_network          = local.networking[each.key]
}

module "network_security_groups_reused" {
  source = "./modules/networking/network_security_group_reused"
  for_each = {
    for key, value in try(local.settings.networking.network_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings        = local.settings
  network_security_group = each.value
  network_watchers       = module.network_watchers
  diagnostics            = local.diagnostics
}

## Route Tables
module "route_tables" {
  source = "./modules/networking/route_tables"
  for_each = {
    for key, value in try(local.settings.networking.route_tables, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "route_tables_reused" {
  source = "./modules/networking/route_tables_reused"
  for_each = {
    for key, value in try(local.settings.networking.route_tables, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings = local.settings
  settings        = each.value
}

## Route Table/Subnet Association
module "rt_subnet_assoc" {
  source = "./modules/networking/route_table_subnet_association"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true #&& try(value.reuse, false) == false
  }

  route_tables             = local.route_tables
  virtual_network_settings = each.value
  virtual_network          = local.networking[each.key]
}

## Virtual network, subnets
module "networking" {
  source = "./modules/networking/virtual_network"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  virtual_network     = each.value
  tags                = try(each.value.tags, null)
}

module "networking_reused" {
  source = "./modules/networking/virtual_network_reused"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true && try(value.use_sharedsvc_provider, false) == false
  }

  global_settings = local.settings
  virtual_network = each.value
}

module "networking_reused_hub" {
  source = "./modules/networking/virtual_network_reused"
  providers = {
    azurerm = azurerm.hub_subscription
  }

  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true && try(value.use_sharedsvc_provider, false) == true
  }

  global_settings = local.settings
  virtual_network = each.value
}

## Virtual network peering
module "virtual_network_peerings" {
  depends_on = [module.networking, module.networking_reused]
  source     = "./modules/networking/virtual_network_peering"
  for_each = {
    for key, value in try(local.settings.networking.virtual_network_peering, {}) : key => value
    if try(value.enabled, false) == true && try(value.use_sharedsvc_provider, false) == false
  }

  global_settings             = local.settings
  resource_group_name         = local.resource_groups[each.value.resource_group_key].name
  vnet_peering                = each.value
  virtual_network_name        = local.networking[each.value.vnet_key].name
  remote_virtual_network_id   = local.networking[each.value.remote_vnet_key].id
  remote_virtual_network_name = local.networking[each.value.remote_vnet_key].name
}

module "virtual_network_peerings_hub" {
  depends_on = [module.networking, module.networking_reused]
  source     = "./modules/networking/virtual_network_peering"
  providers = {
    azurerm = azurerm.hub_subscription
  }

  for_each = {
    for key, value in try(local.settings.networking.virtual_network_peering, {}) : key => value
    if try(value.enabled, false) == true && try(value.use_sharedsvc_provider, false) == true
  }

  global_settings             = local.settings
  resource_group_name         = try(each.value.rg_name, null) != null ? each.value.rg_name : local.resource_groups[each.value.resource_group_key].name
  vnet_peering                = each.value
  virtual_network_name        = local.networking[each.value.vnet_key].name
  remote_virtual_network_id   = local.networking[each.value.remote_vnet_key].id
  remote_virtual_network_name = local.networking[each.value.remote_vnet_key].name
}

module "public_ip_address" {
  source = "./modules/networking/public_ip_addresses"
  for_each = {
    for key, value in try(local.settings.networking.public_ip_addresses, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  public_ip_address   = each.value
  tags                = try(each.value.tags, null)
}

## Bastion Host
module "bastion_host" {
  source = "./modules/networking/bastion_host"
  for_each = {
    for key, value in try(local.settings.networking.bastion_hosts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings      = local.settings
  location             = try(each.value.location, null)
  resource_group_name  = local.resource_groups[each.value.resource_group_key].name
  bastion_subnet_id    = local.networking[each.value.vnet_key].subnets[each.value.subnet_key].id
  public_ip_address_id = module.public_ip_address[each.value.public_ip_address_key].id
  bastion_host         = each.value
  tags                 = try(each.value.tags, null)
}

## Network Watchers
module "network_watchers" {
  source = "./modules/networking/network_watcher"
  for_each = {
    for key, value in try(local.settings.networking.network_watchers, {}) : key => value
    if try(value.enabled, false) == true
  }

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = try(each.value.location, null)
  settings            = each.value
  global_settings     = local.settings
}
