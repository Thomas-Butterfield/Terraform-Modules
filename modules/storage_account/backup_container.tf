locals {
  recovery_vault = try(var.storage_account.backup, null) == null ? null : try(var.recovery_vaults[var.storage_account.backup.vault_key], null)
}

resource "azurerm_backup_container_storage_account" "container" {

  for_each = try(var.storage_account.backup, null) == null ? toset([]) : toset(["enabled"])


  resource_group_name = local.recovery_vault.resource_group_name
  recovery_vault_name = local.recovery_vault.name
  storage_account_id  = azurerm_storage_account.stg.id
}
