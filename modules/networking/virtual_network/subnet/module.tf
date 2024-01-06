
locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{name}{delimiter}{subnet}_{snet_address_prefixes}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.subnet
  resource_type   = "azurerm_subnet"
  name_mask       = try(var.subnet.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_subnet" "subnet" {

  name                 = (var.name == "AzureBastionSubnet") || (var.name == "AzureFirewallSubnet") || (var.name == "GatewaySubnet") || (var.name == "RouteServerSubnet") || (var.name == "AzureFirewallManagementSubnet") ? var.name : module.resource_naming.name_result
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
  ## If left to true, we will not be able to create private endpoints in the given subnet!
  private_endpoint_network_policies_enabled     = try(var.private_endpoint_network_policies_enabled, true)
  private_link_service_network_policies_enabled = try(var.private_link_service_network_policies_enabled, true)

  dynamic "delegation" {
    for_each = try(var.subnet.delegation, null) == null ? [] : [1]

    content {
      name = var.subnet.delegation.name

      service_delegation {
        name    = var.subnet.delegation.service_delegation
        actions = lookup(var.subnet.delegation, "actions", null)
      }
    }
  }

}