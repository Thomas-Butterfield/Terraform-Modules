locals {
  tags = merge(var.tags, var.global_settings.tags, try(var.firewall_policy.tags, null))
  ## 2/16/2022 BStalte: 
  ## azurerm provider  as of this date crashes on azurerm_firewall_policy resource
  ## if tag keys are not lowercase. So forcing it as such here...
  tags_lower = {
    for key, value in local.tags :
    lower(key) => value
  }
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicy}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.firewall_policy
  resource_type   = "azurerm_firewall_policy"
  name_mask       = try(var.firewall_policy.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_firewall_policy" "fwpol" {
  name                = module.resource_naming.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location

  sku                      = try(var.firewall_policy.sku, "Standard")
  base_policy_id           = var.base_policy_id
  threat_intelligence_mode = try(var.firewall_policy.threat_intelligence_mode, "Alert")
  tags                     = local.tags_lower

  dynamic "dns" {
    for_each = try(var.firewall_policy.dns, null) == null ? [] : [1]

    content {
      servers       = try(var.firewall_policy.dns.servers, null)
      proxy_enabled = try(var.firewall_policy.dns.proxy_enabled, false)
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = try(var.firewall_policy.threat_intelligence_allowlist, null) == null ? [] : [1]

    content {
      ip_addresses = try(var.firewall_policy.threat_intelligence_allowlist.ip_addresses, null)
      fqdns        = try(var.firewall_policy.threat_intelligence_allowlist.fqdns, null)
    }
  }

  dynamic "intrusion_detection" {
    for_each = try(var.firewall_policy.intrusion_detection, null) == null ? [] : [1]

    content {
      mode = try(var.firewall_policy.intrusion_detection.mode, "Off")

      dynamic "signature_overrides" {
        for_each = try(var.firewall_policy.intrusion_detection.signature_overrides, {})

        content {
          id    = try(signature_overrides.value.id, null)
          state = try(signature_overrides.value.state, null)
        }
      }
      dynamic "traffic_bypass" {
        for_each = try(var.firewall_policy.intrusion_detection.traffic_bypass, {})

        content {
          name                  = traffic_bypass.value.name
          protocol              = traffic_bypass.value.protocol
          description           = try(traffic_bypass.value.description, null)
          destination_addresses = try(traffic_bypass.value.destination_addresses, null)
          destination_ip_groups = try(traffic_bypass.value.destination_ip_groups, null)
          destination_ports     = try(traffic_bypass.value.destination_ports, null)
          source_addresses      = try(traffic_bypass.value.source_addresses, null)
          source_ip_groups      = try(traffic_bypass.value.source_ip_groups, null)

        }
      }
    }
  }
}