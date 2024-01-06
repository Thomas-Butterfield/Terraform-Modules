locals {
  name_mask = "{envlabel}{delimiter}{dnszonevnetlink}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  # name            = each.key # Use vnet_links key for the name
  resource_type = "azurerm_private_dns_zone_virtual_network_link"
  name_mask     = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  name                  = module.resource_naming.name_result
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  #virtual_network_id    = try(var.vnets[each.value.vnet_key].id, try(var.vnets[each.value.vnet_key].id, each.value.virtual_network_id))
  virtual_network_id   = var.vnet_id
  registration_enabled = try(var.settings.registration_enabled, false)
  # tags                 = local.tags
}
