locals {
  naming_combined_settings = merge(var.vhub_connection, { address_space = "${var.vnet_address_space}" })
  name_mask                = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vhub}{delimiter}{vnet_address_space}{delimiter}Conn{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = local.naming_combined_settings
  resource_type   = "azurerm_virtual_hub_connection"
  name_mask       = try(var.vhub_connection.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_virtual_hub_connection" "vhubconn_data" {

  name                      = module.resource_naming.name_result
  virtual_hub_id            = try(var.virtual_hub_id, null) != null ? var.virtual_hub_id : var.virtual_hub.id
  remote_virtual_network_id = var.virtual_network_id
  internet_security_enabled = try(var.vhub_connection.internet_security_enabled, false)

  provider = azurerm.vhub_provider

  count = var.virtual_hub_as_data ? 1 : 0

  dynamic "routing" {
    for_each = try(var.vhub_connection.assoc_to_custom_route_table, false) ? [1] : []
    content {
      associated_route_table_id = try(var.vhub_connection.assoc_route_table_resource_id, null)
      propagated_route_table {
        labels          = try(var.vhub_connection.prop_route_table_labels, null)
        route_table_ids = try(var.vhub_connection.prop_route_table_resource_ids, null)
      }

      dynamic "static_vnet_route" {
        for_each = try(var.vhub_connection.static_vnet_route_next_hop_ip_address, null) != null ? [1] : []
        content {
          name                = try(var.vhub_connection.static_vnet_route_name, null)
          address_prefixes    = try(var.vhub_connection.static_vnet_route_address_prefixes, null)
          next_hop_ip_address = try(var.vhub_connection.static_vnet_route_next_hop_ip_address, null)
        }
      }
    }
  }

}

resource "azurerm_virtual_hub_connection" "vhubconn" {

  name                      = module.resource_naming.name_result
  virtual_hub_id            = try(var.virtual_hub_id, null) != null ? var.virtual_hub_id : var.virtual_hub.id
  remote_virtual_network_id = var.virtual_network_id
  internet_security_enabled = try(var.vhub_connection.internet_security_enabled, false)

  count = var.virtual_hub_as_data ? 0 : 1

  dynamic "routing" {
    for_each = try(var.vhub_connection.assoc_to_custom_route_table, false) ? [1] : []
    content {
      associated_route_table_id = try(var.vhub_connection.assoc_route_table_resource_id, null)
      propagated_route_table {
        route_table_ids = try(var.vhub_connection.prop_route_table_resource_ids, null)
      }
    }
  }

}
