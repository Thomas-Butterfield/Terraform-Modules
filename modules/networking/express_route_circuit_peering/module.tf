locals {
  tags = merge(var.global_settings.tags, try(var.settings.tags, null))
}

resource "azurerm_express_route_circuit_peering" "er_circuit_peering" {

  resource_group_name           = var.resource_group_name
  express_route_circuit_name    = var.express_route_circuit_name
  peering_type                  = var.settings.peering_type # Acceptable values include AzurePrivatePeering, AzurePublicPeering and MicrosoftPeering
  primary_peer_address_prefix   = var.settings.primary_peer_address_prefix
  secondary_peer_address_prefix = var.settings.secondary_peer_address_prefix
  vlan_id                       = var.settings.vlan_id

  # Optional
  peer_asn   = try(var.settings.peer_asn, null)
  shared_key = try(var.settings.shared_key, null)

  #
  # For Microsoft peering
  # Required when peering_type is set to MicrosoftPeering
  #

  dynamic "microsoft_peering_config" {
    for_each = try(var.settings.microsoft_peering_config, null) == null ? [] : [1]

    content {
      advertised_public_prefixes = var.settings.microsoft_peering_config.advertised_public_prefixes
      customer_asn               = try(var.settings.microsoft_peering_config.customer_asn, null)
      routing_registry_name      = try(var.settings.microsoft_peering_config.routing_registry_name, null)
    }
  }

  dynamic "ipv6" {
    for_each = try(var.settings.ipv6, null) == null ? [] : [1]

    content {
      primary_peer_address_prefix   = var.settings.ipv6.primary_peer_address_prefix
      secondary_peer_address_prefix = var.settings.ipv6.secondary_peer_address_prefix

      # To be added when route filter is added to the core aztfmod module
      # route_filter_id =

      microsoft_peering {
        advertised_public_prefixes = var.settings.ipv6.microsoft_peering.advertised_public_prefixes
        customer_asn               = try(var.settings.ipv6.microsoft_peering.customer_asn, null)
        routing_registry_name      = try(var.settings.ipv6.microsoft_peering.routing_registry_name, null)
      }
    }
  }

}
