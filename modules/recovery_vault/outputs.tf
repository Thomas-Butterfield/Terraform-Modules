output "id" {
  description = "The ID of the Recovery Vault"
  value       = azurerm_recovery_services_vault.asr.id
}

output "name" {
  description = "The Name of the Recovery Vault"
  value       = azurerm_recovery_services_vault.asr.name
}

output "backup_policies" {
  description = "The Backup Policies map object of the Recovery Vault"
  value = {
    virtual_machines = azurerm_backup_policy_vm.vm
    file_shares      = azurerm_backup_policy_file_share.fs
  }
}

output "replication_policies" {
  description = "The Replication Policy resource object of the Recovery Vault"
  value       = azurerm_site_recovery_replication_policy.policy
}

output "soft_delete_enabled" {
  description = "(Bool) Soft Delete Enabled Flag of the Recovery Vault"
  value       = try(var.recovery_vault.soft_delete_enabled, true)
}

output "principal_id" {
  description = "The Identity Principal ID of the Recovery Vault"
  value       = try(azurerm_recovery_services_vault.asr.identity.0.principal_id, null)
}
