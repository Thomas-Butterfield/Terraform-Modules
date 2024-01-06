locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{keyvault}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.key_vault
  resource_type   = "azurerm_key_vault"
  name_mask       = try(var.key_vault.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_key_vault" "keyvault" {

  name                            = module.resource_naming.name_result
  location                        = var.location != null ? var.location : var.global_settings.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = try(var.key_vault.sku_name, "standard")
  tags                            = local.tags
  enabled_for_deployment          = try(var.key_vault.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.key_vault.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.key_vault.enabled_for_template_deployment, false)
  enable_rbac_authorization       = try(var.key_vault.enable_rbac_authorization, false)
  purge_protection_enabled        = try(var.key_vault.purge_protection_enabled, false)
  soft_delete_retention_days      = try(var.key_vault.soft_delete_retention_days, 90)

  dynamic "network_acls" {
    for_each = lookup(var.key_vault, "network", null) == null ? [] : [1]

    content {
      bypass         = var.key_vault.network.bypass
      default_action = try(var.key_vault.network.default_action, "Deny")
      ip_rules       = try(var.key_vault.network.ip_rules, null)
      virtual_network_subnet_ids = try(var.key_vault.network.subnets, null) == null ? null : [
        for key, value in var.key_vault.network.subnets : try(var.virtual_networks[value.vnet_key].subnets[value.subnet_key].id, null)
      ]
    }
  }

  dynamic "contact" {
    for_each = lookup(var.key_vault, "contacts", {})

    content {
      email = contact.value.email
      name  = try(contact.value.name, null)
      phone = try(contact.value.phone, null)
    }
  }

  lifecycle {
    ignore_changes = [
      resource_group_name, location
    ]
  }
}
