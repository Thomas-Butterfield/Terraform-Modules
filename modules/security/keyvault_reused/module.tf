data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault.name
  resource_group_name = var.key_vault.rg_name
}
