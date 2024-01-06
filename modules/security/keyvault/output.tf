output "id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "name" {
  description = "The Name of the Key Vault"
  value       = azurerm_key_vault.keyvault.name
}

output "vault_uri" {
  description = "The Key Vault URL of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}
