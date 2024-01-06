locals {
  tags      = merge(var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vng}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_virtual_network_gateway"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_network_gateway" "vngw" {
  name                             = module.resource_naming.name_result
  resource_group_name              = var.resource_group_name
  location                         = var.location != null ? var.location : var.global_settings.location
  sku                              = var.settings.sku
  type                             = var.settings.type
  active_active                    = try(var.settings.active_active, false)
  default_local_network_gateway_id = try(var.settings.default_local_network_gateway_id, null) # If not specified, forced tunnelling is disabled
  edge_zone                        = try(var.settings.edge_zone, null)
  vpn_type                         = try(var.settings.vpn_type, "RouteBased")
  enable_bgp                       = try(var.settings.enable_bgp, false)
  generation                       = try(var.settings.generation, null)
  private_ip_address_enabled       = try(var.settings.private_ip_address_enabled, null)
  tags                             = local.tags

  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configuration, {})
    content {
      name                          = try(ip_configuration.value.name, "vnetGatewayConfig")
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      subnet_id                     = try(ip_configuration.value.subnet_id, var.virtual_networks[ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id, null)
      public_ip_address_id          = try(ip_configuration.value.public_ip_address_id, var.public_ip_addresses[ip_configuration.value.public_ip_address_key].id, null)
    }
  }

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn         = try(bgp_settings.value.asn, "65515")
      peer_weight = try(bgp_settings.value.peer_weight, null)

      dynamic "peering_addresses" {
        for_each = try(bgp_settings.value.peering_addresses, {})
        content {
          ip_configuration_name = try(peering_addresses.value.ip_configuration_name, null)
          apipa_addresses       = try(peering_addresses.value.apipa_addresses, null)
        }
      }

    }
  }

  dynamic "vpn_client_configuration" {
    for_each = try(var.settings.vpn_client_configuration, {})
    content {
      address_space         = vpn_client_configuration.value.address_space
      aad_tenant            = try(vpn_client_configuration.value.aad_tenant, null)
      aad_audience          = try(vpn_client_configuration.value.aad_audience, null)
      aad_issuer            = try(vpn_client_configuration.value.aad_issuer, null)
      radius_server_address = try(vpn_client_configuration.value.radius_server_address, null)
      radius_server_secret  = try(vpn_client_configuration.value.radius_server_secret, null)
      vpn_client_protocols  = try(vpn_client_configuration.value.vpn_client_protocols, null)
      vpn_auth_types        = try(vpn_client_configuration.value.vpn_auth_types, null)

      dynamic "root_certificate" {
        for_each = try(var.settings.vpn_client_configuration.root_certificate, {})
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      dynamic "revoked_certificate" {
        for_each = try(var.settings.vpn_client_configuration.revoked_certificate, {})
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }

    }
  }

  dynamic "custom_route" {
    for_each = try(var.settings.custom_route, {})
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

}
