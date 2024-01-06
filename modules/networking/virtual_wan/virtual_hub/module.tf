locals {
  vhub_name_mask   = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vhub}{delimiter}{postfix}"
  spp_name_mask    = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}SPP{delimiter}{postfix}"
  hub_ip_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}VHUBMGMTIP{delimiter}{postfix}"
  bgp_name_mask    = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}VHUBBGPCONN{delimiter}{postfix}"
}

module "resource_naming_vhub" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.virtual_hub
  resource_type   = "azurerm_virtual_hub"
  name_mask       = try(var.virtual_hub.naming_convention.name_mask, local.vhub_name_mask)
}

module "resource_naming_spp" {
  source   = "../../../resource_naming"
  for_each = try(var.virtual_hub.security_partner_provider, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_virtual_hub"
  name_mask       = try(each.value.naming_convention.name_mask, local.spp_name_mask)
}

module "resource_naming_hub_ip" {
  source   = "../../../resource_naming"
  for_each = try(var.virtual_hub.hub_ip, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_virtual_hub"
  name_mask       = try(each.value.naming_convention.name_mask, local.hub_ip_name_mask)
}

module "resource_naming_bgp" {
  source   = "../../../resource_naming"
  for_each = try(var.virtual_hub.bgp_connection, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_virtual_hub"
  name_mask       = try(each.value.naming_convention.name_mask, local.bgp_name_mask)
}

## creates a virtual hub in the region
resource "azurerm_virtual_hub" "vwan_hub" {
  name                = module.resource_naming_vhub.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.virtual_hub.hub_address_prefix
  tags                = var.tags

  dynamic "route" {
    for_each = try(var.virtual_hub.routes, {})

    content {
      address_prefixes    = route.value.address_prefixes
      next_hop_ip_address = route.value.next_hop_ip_address
    }
  }

  timeouts {
    create = "60m"
    delete = "180m"
  }
}

# resource "azurerm_virtual_hub_security_partner_provider" "spp" {
#   depends_on = [azurerm_vpn_gateway.s2s_gateway]
#   for_each   = try(var.virtual_hub.security_partner_provider, {})

#   name                   = module.resource_naming_spp[each.key].name_result
#   resource_group_name    = var.resource_group_name
#   location               = var.global_settings.location
#   virtual_hub_id         = azurerm_virtual_hub.vwan_hub.id
#   security_provider_name = each.value.security_provider_name
#   tags                   = var.tags
# }

## This resource is used when client wants to manage the Private and Public IP addresses of the Virtual Hub resource
# resource "azurerm_virtual_hub_ip" "hub_ip" {
#   for_each = try(var.virtual_hub.hub_ip, {})

#   name                         = module.resource_naming_hub_ip[each.key].name_result
#   virtual_hub_id               = azurerm_virtual_hub.vwan_hub.id
#   private_ip_address           = each.value.private_ip_address
#   private_ip_allocation_method = each.value.private_ip_allocation_method
#   public_ip_address_id         = try(each.value.private_ip_address_id, null) != null ? each.value.private_ip_address_id : var.public_ip_addresses[each.value.public_ip_address.public_ip_address_key].id
#   subnet_id                    = try(each.value.subnet_id, null) != null ? each.value.subnet_id : var.virtual_networks[each.value.subnet.vnet_key].subnets[each.value.subnet.subnet_key].id
# }

# resource "azurerm_virtual_hub_bgp_connection" "bgp_con" {
#   depends_on = [azurerm_virtual_hub_ip.hub_ip]
#   for_each   = try(var.virtual_hub.bgp_connection, {})

#   name           = module.resource_naming_bgp[each.key].name_result
#   virtual_hub_id = azurerm_virtual_hub.vwan_hub.id
#   peer_asn       = each.value.peer_asn
#   peer_ip        = each.value.peer_ip
# }
