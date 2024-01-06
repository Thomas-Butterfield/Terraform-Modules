
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{mlwksp}"

  managed_identities = flatten([
    for managed_identity_key in try(var.ml_workspace.identity.managed_identity_keys, []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])

}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.ml_workspace
  resource_type   = "azurerm_machine_learning_workspace"
  name_mask       = try(var.ml_workspace.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_machine_learning_workspace" "ws" {
  name                           = module.resource_naming.name_result
  location                       = var.location != null ? var.location : var.global_settings.location
  resource_group_name            = var.resource_group_name
  application_insights_id        = var.app_insights[var.ml_workspace.app_insights_key].id
  key_vault_id                   = var.key_vaults[var.ml_workspace.keyvault_key].id
  storage_account_id             = var.storage_accounts[var.ml_workspace.sa_key].id
  container_registry_id          = try(var.ml_workspace.container_registry_id, null)
  public_network_access_enabled  = try(var.ml_workspace.public_network_access_enabled, null)
  image_build_compute_name       = try(var.ml_workspace.image_build_compute_name, null)
  description                    = try(var.ml_workspace.description, null)
  friendly_name                  = try(var.ml_workspace.friendly_name, null)
  high_business_impact           = try(var.ml_workspace.high_business_impact, null)
  primary_user_assigned_identity = try(var.ml_workspace.identity.primary_user_assigned_identity_key, null) != null ? try(var.managed_identities[var.ml_workspace.identity.primary_user_assigned_identity_key].id, null) : null
  v1_legacy_mode_enabled         = try(var.ml_workspace.v1_legacy_mode_enabled, false)
  sku_name                       = try(var.ml_workspace.sku_name, "Basic")
  tags                           = local.tags

  ## SystemAssigned, UserAssigned, "SystemAssigned, UserAssigned" (to enable both)
  dynamic "identity" {
    for_each = try(var.ml_workspace.identity, {}) == {} ? [] : [1]

    content {
      type         = var.ml_workspace.identity.type
      identity_ids = concat(local.managed_identities, try(var.ml_workspace.identity.identity_ids, []))
    }
  }

  dynamic "encryption" {
    for_each = try(var.ml_workspace.encryption, {}) == {} ? [] : [1]

    content {
      user_assigned_identity_id = try(var.ml_workspace.encryption.user_assigned_identity_key, null) != null ? try(var.managed_identities[var.ml_workspace.encryption.user_assigned_identity_key].id, null) : null
      key_vault_id              = try(var.ml_workspace.encryption.keyvault_key, null) != null ? try(var.key_vaults[var.ml_workspace.encryption.keyvault_key].id, null) : null
      key_id                    = try(var.ml_workspace.encryption.key_id_key, null) != null ? try(var.key_vault_keys[var.ml_workspace.encryption.key_id_key].id, null) : null
    }
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "120m"
  }

}
