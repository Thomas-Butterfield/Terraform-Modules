locals {
  rcg_name_mask     = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicyrcg}"
  netrule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicynetrule}"
  apprule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicyapprule}"
  natrule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicynatrule}"
}

module "resource_naming_rcg" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.policy_settings
  resource_type   = "azurerm_firewall_policy_rule_collection_group"
  name_mask       = try(var.policy_settings.naming_convention.name_mask, local.rcg_name_mask)
}

module "resource_naming_netrule" {
  source   = "../../resource_naming"
  for_each = try(var.policy_settings.network_rule_collections, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_firewall_network_rule_collection"
  name_mask       = try(each.value.naming_convention.name_mask, local.netrule_name_mask)
}

module "resource_naming_apprule" {
  source   = "../../resource_naming"
  for_each = try(var.policy_settings.application_rule_collections, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_firewall_application_rule_collection"
  name_mask       = try(each.value.naming_convention.name_mask, local.apprule_name_mask)
}

module "resource_naming_natrule" {
  source   = "../../resource_naming"
  for_each = try(var.policy_settings.nat_rule_collections, {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_firewall_nat_rule_collection"
  name_mask       = try(each.value.naming_convention.name_mask, local.natrule_name_mask)
}

resource "azurerm_firewall_policy_rule_collection_group" "polgroup" {
  name               = module.resource_naming_rcg.name_result
  priority           = var.policy_settings.priority
  firewall_policy_id = var.firewall_policy_id

  dynamic "application_rule_collection" {
    for_each = try(var.policy_settings.application_rule_collections, {})

    content {
      name     = module.resource_naming_apprule[application_rule_collection.key].name_result
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = try(application_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_fqdn_tags = try(rule.value.destination_fqdn_tags, null)
          destination_fqdns     = try(rule.value.destination_fqdns, null)

          dynamic "protocols" {
            for_each = try(rule.value.protocols, {})

            content {
              type = protocols.value.type
              port = try(protocols.value.port, null)
            }
          }
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = try(var.policy_settings.network_rule_collections, {})

    content {
      name     = module.resource_naming_netrule[network_rule_collection.key].name_result
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = try(network_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_addresses = try(rule.value.destination_addresses, null)
          destination_fqdns     = try(rule.value.destination_fqdns, null)
          destination_ip_groups = try(rule.value.destination_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.destination_ip_groups_keys, key)
            ]), null)
          )
          destination_ports = rule.value.destination_ports
          protocols         = rule.value.protocols
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = try(var.policy_settings.nat_rule_collections, {})

    content {
      name     = module.resource_naming_natrule[nat_rule_collection.key].name_result
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = try(nat_rule_collection.value.rules, {})

        content {
          name             = rule.value.name
          source_addresses = try(rule.value.source_addresses, null)
          source_ip_groups = try(rule.value.source_ip_groups, try(flatten([
            for key, value in var.ip_groups : value.id
            if contains(rule.value.source_ip_groups_keys, key)
            ]), null)
          )
          destination_ports = try(rule.value.destination_ports, null)
          destination_address = try(rule.value.destination_address, try(flatten([
            for key, value in var.public_ip_addresses : value.ip_address
            if contains(rule.value.destination_address_public_ip_key, key)
            ]), null)
          )
          translated_port    = rule.value.translated_port
          translated_address = rule.value.translated_address
          protocols          = rule.value.protocols
        }
      }
    }
  }


}
