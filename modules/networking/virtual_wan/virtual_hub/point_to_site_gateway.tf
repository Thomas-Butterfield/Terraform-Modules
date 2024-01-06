locals {
  p2s_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{p2svpn}{delimiter}{postfix}"
}

module "resource_naming_p2s" {
  source = "../../../resource_naming"
  count  = try(var.virtual_hub.deploy_p2s, false) ? 1 : 0

  global_settings = var.global_settings
  settings        = var.virtual_hub
  resource_type   = "azurerm_point_to_site_vpn_gateway"
  name_mask       = try(var.virtual_hub.naming_convention.name_mask, local.p2s_name_mask)
}

## create the VPN P2S if var.vwan.p2s_gateway is set to true
resource "azurerm_point_to_site_vpn_gateway" "p2s_gateway" {
  depends_on = [azurerm_virtual_hub.vwan_hub, azurerm_vpn_server_configuration.p2s_configuration]
  count      = try(var.virtual_hub.deploy_p2s, false) ? 1 : 0

  name                        = module.resource_naming_p2s.0.name_result
  location                    = var.location != null ? var.location : var.global_settings.location
  resource_group_name         = var.resource_group_name
  tags                        = var.tags
  virtual_hub_id              = azurerm_virtual_hub.vwan_hub.id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.p2s_configuration[0].id

  scale_unit = var.virtual_hub.p2s_config.scale_unit

  dynamic "connection_configuration" {
    for_each = try(var.virtual_hub.p2s_config.connection_configuration, {}) != {} ? [1] : []

    content {
      name = var.virtual_hub.p2s_config.connection_configuration.name

      dynamic "vpn_client_address_pool" {
        for_each = var.virtual_hub.p2s_config.connection_configuration.vpn_client_address_pool
        content {
          address_prefixes = var.virtual_hub.p2s_config.connection_configuration.vpn_client_address_pool.address_prefixes
        }
      }
    }
  }

  timeouts {
    create = "60m"
    delete = "120m"
  }

}

# ## creates the VPN P2S server configuration, this is required for P2S site.
resource "azurerm_vpn_server_configuration" "p2s_configuration" {
  depends_on = [azurerm_virtual_hub.vwan_hub]
  count      = try(var.virtual_hub.deploy_p2s, false) ? 1 : 0

  name                     = module.resource_naming_p2s.0.name_result
  location                 = var.global_settings.location
  resource_group_name      = var.resource_group_name
  tags                     = var.tags
  vpn_authentication_types = var.virtual_hub.p2s_config.server_config.vpn_authentication_types

  client_root_certificate {
    name             = var.virtual_hub.p2s_config.server_config.client_root_certificate.name
    public_cert_data = var.virtual_hub.p2s_config.server_config.client_root_certificate.public_cert_data
  }

}

