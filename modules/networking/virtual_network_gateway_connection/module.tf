locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vngc}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_network_gateway_connection"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_network_gateway_connection" "vngwc" {
  name                               = module.resource_naming.name_result
  resource_group_name                = var.resource_group_name
  location                           = var.location != null ? var.location : var.global_settings.location
  type                               = var.settings.type
  virtual_network_gateway_id         = var.virtual_network_gateway_id
  authorization_key                  = var.express_route_authorization_key
  dpd_timeout_seconds                = try(var.settings.dpd_timeout_seconds, null)
  express_route_circuit_id           = var.express_route_circuit_id
  peer_virtual_network_gateway_id    = var.peer_virtual_network_gateway_id
  local_azure_ip_address_enabled     = try(var.settings.local_azure_ip_address_enabled, null)
  local_network_gateway_id           = var.local_network_gateway_id
  routing_weight                     = try(var.settings.routing_weight, "10")
  shared_key                         = try(var.settings.shared_key, null)
  connection_mode                    = try(var.settings.connection_mode, "Default")
  connection_protocol                = try(var.settings.connection_protocol, null)
  enable_bgp                         = try(var.settings.enable_bgp, null)
  express_route_gateway_bypass       = try(var.settings.express_route_gateway_bypass, null)
  egress_nat_rule_ids                = try(var.settings.egress_nat_rule_ids, null)
  ingress_nat_rule_ids               = try(var.settings.ingress_nat_rule_ids, null)
  use_policy_based_traffic_selectors = try(var.settings.use_policy_based_traffic_selectors, false)
  tags                               = local.tags

  dynamic "custom_bgp_addresses" {
    for_each = try(var.settings.custom_bgp_addresses, {})
    content {
      primary   = custom_bgp_addresses.value.primary
      secondary = custom_bgp_addresses.value.secondary
    }
  }

  dynamic "ipsec_policy" {
    for_each = try(var.settings.ipsec_policy, {})
    content {
      dh_group         = ipsec_policy.value.dh_group
      ike_encryption   = ipsec_policy.value.ike_encryption
      ike_integrity    = ipsec_policy.value.ike_integrity
      ipsec_encryption = ipsec_policy.value.ipsec_encryption
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity
      pfs_group        = ipsec_policy.value.pfs_group
      sa_datasize      = try(ipsec_policy.value.sa_datasize, "102400000")
      sa_lifetime      = try(ipsec_policy.value.sa_lifetime, "27000")
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = try(var.settings.traffic_selector_policy, {})
    content {
      local_address_cidrs  = traffic_selector_policy.value.local_address_cidrs
      remote_address_cidrs = traffic_selector_policy.value.remote_address_cidrs
    }
  }

}
