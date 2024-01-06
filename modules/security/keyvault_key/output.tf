output "id" {
  description = "The ID of the Key Vault Key"
  value       = azurerm_key_vault_key.key.id
}

output "name" {
  description = "The Name of the Key Vault Key"
  value       = azurerm_key_vault_key.key.name
}
