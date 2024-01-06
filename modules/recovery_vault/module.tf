locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{rsv}"
}

module "resource_naming" {
  source = "../resource_naming"

  global_settings = var.global_settings
  settings        = var.recovery_vault
  resource_type   = "azurerm_recovery_services_vault"
  name_mask       = try(var.recovery_vault.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_recovery_services_vault" "asr" {
  name                         = module.resource_naming.name_result
  location                     = var.location != null ? var.location : var.global_settings.location
  resource_group_name          = var.resource_group_name
  sku                          = var.sku
  tags                         = local.tags
  soft_delete_enabled          = try(var.recovery_vault.soft_delete_enabled, true)
  storage_mode_type            = try(var.recovery_vault.storage_mode_type, "GeoRedundant")
  cross_region_restore_enabled = try(var.recovery_vault.cross_region_restore_enabled, false)

  dynamic "identity" {
    for_each = try(var.recovery_vault.enable_identity, false) == true ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "encryption" {
    for_each = try(var.recovery_vault.enable_encryption, false) == true ? [1] : []
    content {
      key_id                            = try(var.recovery_vault.encryption.key_id, null)
      infrastructure_encryption_enabled = try(var.recovery_vault.encryption.infrastructure_encryption_enabled, true)
      use_system_assigned_identity      = try(var.recovery_vault.encryption.use_system_assigned_identity, true)
    }
  }
}
