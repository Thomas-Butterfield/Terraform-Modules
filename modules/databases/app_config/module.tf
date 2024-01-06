
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{app_config}{delimiter}{postfix}"

  managed_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])

}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_app_configuration"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_app_configuration" "config" {
  name                       = module.resource_naming.name_result
  resource_group_name        = var.resource_group_name
  location                   = var.location != null ? var.location : var.global_settings.location
  tags                       = local.tags
  sku                        = try(var.settings.sku_name, "standard")
  local_auth_enabled         = try(var.settings.local_auth_enabled, true)
  public_network_access      = try(var.settings.public_network_access, null)
  purge_protection_enabled   = try(var.settings.public_network_access, false)
  soft_delete_retention_days = try(var.settings.soft_delete_retention_days, null)

  dynamic "encryption" {
    for_each = lookup(var.settings, "encryption", {}) == {} ? [] : [1]

    content {
      key_vault_key_identifier = try(var.settings.encryption.key_id_key, null) != null ? try(var.key_vault_keys[var.settings.encryption.key_id_key].id, null) : null
      identity_client_id       = try(var.settings.encryption.user_assigned_identity_key, null) != null ? try(var.managed_identities[var.settings.encryption.user_assigned_identity_key].client_id, null) : null
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = concat(local.managed_identities, try(var.settings.identity.identity_ids, []))
    }
  }
}
