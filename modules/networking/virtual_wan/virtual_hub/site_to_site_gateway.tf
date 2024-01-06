locals {
  s2s_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vpng}{delimiter}{postfix}"
}

module "resource_naming_s2s" {
  source = "../../../resource_naming"
  count  = try(var.virtual_hub.deploy_s2s, false) ? 1 : 0

  global_settings = var.global_settings
  settings        = var.virtual_hub
  resource_type   = "azurerm_vpn_gateway"
  name_mask       = try(var.virtual_hub.naming_convention.name_mask, local.s2s_name_mask)
}

## create the VPN S2S if var.vwan.s2s_gateway is set to true
resource "azurerm_vpn_gateway" "s2s_gateway" {
  depends_on = [azurerm_virtual_hub.vwan_hub]
  count      = try(var.virtual_hub.deploy_s2s, false) ? 1 : 0

  name                = module.resource_naming_s2s.0.name_result
  location            = var.location != null ? var.location : var.global_settings.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub.id

  scale_unit = try(var.virtual_hub.s2s_config.scale_unit, 1)

  dynamic "bgp_settings" {
    for_each = try(var.virtual_hub.s2s_config.bgp_settings, null) == null ? [] : [1]

    content {
      asn         = var.virtual_hub.s2s_config.bgp_settings.asn
      peer_weight = var.virtual_hub.s2s_config.bgp_settings.peer_weight

      dynamic "instance_0_bgp_peering_address" {
        for_each = try(var.virtual_hub.s2s_config.bgp_settings.instance_0_bgp_peering_address, null) == null ? [] : [1]

        content {
          custom_ips = var.virtual_hub.s2s_config.bgp_settings.instance_0_bgp_peering_address.custom_ips
        }
      }

      dynamic "instance_1_bgp_peering_address" {
        for_each = try(var.virtual_hub.s2s_config.bgp_settings.instance_1_bgp_peering_address, null) == null ? [] : [1]

        content {
          custom_ips = var.virtual_hub.s2s_config.bgp_settings.instance_1_bgp_peering_address.custom_ips
        }
      }

    }
  }

  timeouts {
    create = "60m"
    delete = "120m"
  }
}