locals {
  tags      = merge(var.tags, var.global_settings.tags, try(var.firewall.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewall}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.firewall
  resource_type   = "azurerm_firewall"
  name_mask       = try(var.firewall.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_firewall" "fw" {

  dns_servers         = try(var.firewall.dns_servers, null)
  firewall_policy_id  = var.firewall_policy_id
  location            = var.location != null ? var.location : var.global_settings.location
  name                = module.resource_naming.name_result
  private_ip_ranges   = try(var.firewall.private_ip_ranges, null)
  resource_group_name = var.resource_group_name
  sku_name            = try(var.firewall.sku_name, "AZFW_VNet")
  sku_tier            = try(var.firewall.sku_tier, "Standard")
  tags                = local.tags
  # 3.0 provider change: The default value for the field threat_intel_mode will change from "Alert" to null and will not accept "" as a valid value.
  threat_intel_mode = try(var.firewall.vhub_key, null) != null ? null : try(var.firewall.threat_intel_mode, null)
  zones             = try(var.firewall.zones, null)

  ## direct public_ip_id reference
  dynamic "ip_configuration" {
    for_each = try([var.firewall.public_ip_id], {})

    content {
      name                 = "public-ip"
      public_ip_address_id = ip_configuration.value.public_ip_id
      subnet_id            = var.subnet_id
    }
  }

  ## configuration structure for public_ips list
  dynamic "ip_configuration" {
    for_each = try(var.firewall.public_ips, {})

    content {
      name                 = ip_configuration.value.name
      public_ip_address_id = try(ip_configuration.value.public_ip_id, null) != null ? ip_configuration.value.public_ip_id : var.public_ip_addresses[ip_configuration.value.public_ip_key].id
      subnet_id            = try(ip_configuration.value.subnet_id, null) != null ? ip_configuration.value.subnet_id : var.virtual_networks[ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id
    }
  }

  dynamic "management_ip_configuration" {
    for_each = try(var.firewall.management_ip_configuration, null) != null ? [var.firewall.management_ip_configuration] : []
    content {
      name                 = management_ip_configuration.value.name
      public_ip_address_id = try(management_ip_configuration.value.public_ip_address_id, null) != null ? management_ip_configuration.value.public_ip_address_id : var.public_ip_addresses[management_ip_configuration.value.public_ip_key].id
      subnet_id            = try(management_ip_configuration.value.subnet_id, null) != null ? management_ip_configuration.value.subnet_id : var.virtual_networks[management_ip_configuration.value.vnet_key].subnets[management_ip_configuration.value.subnet_key].id
    }
  }

  dynamic "virtual_hub" {
    for_each = try(var.firewall.vhub_key, null) != null ? [1] : []
    content {
      virtual_hub_id = coalesce(
        try(var.virtual_wans[var.firewall.vwan_key].virtual_hubs[var.firewall.vhub_key].id, null),
        try(var.virtual_hubs[var.firewall.vhub_key].id, null)
      )

      public_ip_count = try(var.firewall.public_ip_count, 1)
    }
  }
}
