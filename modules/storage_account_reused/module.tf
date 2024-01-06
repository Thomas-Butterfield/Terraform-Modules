locals {
  tags = merge(var.global_settings.tags, var.tags, try(var.storage_account.tags, null))
}

data "azurerm_storage_account" "stg" {
  name                = var.storage_account.name
  resource_group_name = var.storage_account.rg_name
}
