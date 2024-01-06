locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{name}{delimiter}{publicip}"
}


module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.public_ip_address
  resource_type   = "azurerm_public_ip"
  name_mask       = try(var.public_ip_address.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_public_ip" "pip" {
  name                    = module.resource_naming.name_result
  resource_group_name     = var.resource_group_name
  location                = var.location != null ? var.location : var.global_settings.location
  allocation_method       = try(var.public_ip_address.allocation_method, "Static")
  sku                     = try(var.public_ip_address.sku, "Standard")
  ip_version              = try(var.public_ip_address.ip_version, "IPv4")
  idle_timeout_in_minutes = try(var.public_ip_address.idle_timeout_in_minutes, null)
  domain_name_label       = try(var.public_ip_address.generate_domain_name_label, false) ? var.public_ip_address.name : try(var.public_ip_address.domain_name_label, null)
  reverse_fqdn            = try(var.public_ip_address.reverse_fqdn, null)
  zones                   = try(var.public_ip_address.zones, null)
  public_ip_prefix_id     = var.public_ip_prefix_id
  ip_tags                 = try(var.public_ip_address.ip_tags, {})
  ddos_protection_mode    = try(var.public_ip_address.ddos_protection_mode, "VirtualNetworkInherited")
  ddos_protection_plan_id = try(var.public_ip_address.ddos_protection_plan_id, null)
  edge_zone               = try(var.public_ip_address.edge_zone, null)
  sku_tier                = try(var.public_ip_address.sku_tier, "Regional")
  tags                    = local.tags
}
