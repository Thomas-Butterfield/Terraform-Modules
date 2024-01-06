
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_app_configuration_key"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_app_configuration_key" "config" {
  key                    = module.resource_naming.name_result
  configuration_store_id = var.configuration_store_id
  content_type           = try(var.settings.content_type, null)
  label                  = try(var.settings.label, null)
  value                  = try(var.settings.value, null)
  locked                 = try(var.settings.locked, null)
  type                   = try(var.settings.type, null)
  vault_key_reference_id = try(var.settings.vault_key_reference_id, null)
  ## Unfinished until we actually need to reference a provisioned keyvault secret managed in TF
  # vault_key_reference    = try(coalesce(
  #   try(var.settings.vault_key_reference_id, null),
  #   try(var.settings.keyvault_id, null) try(var.settings.keyvault_key, null) try(var.settings.vault_key_secret_key, null),
  #   try(var.settings.vault_key_reference_id, null)
  # ), null) # When setting the vault_key_reference using the id will pin the value to specific version of the secret, to reference latest secret value use versionless_id
  tags = local.tags
}
