
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{mssql_server}{delimiter}{postfix}"

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
  resource_type   = "azurerm_mssql_server"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_server" "mssql" {
  name                                 = module.resource_naming.name_result
  location                             = var.location != null ? var.location : var.global_settings.location
  resource_group_name                  = var.resource_group_name
  version                              = try(var.settings.version, "12.0")
  administrator_login                  = var.settings.administrator_login
  administrator_login_password         = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
  connection_policy                    = try(var.settings.connection_policy, null)
  minimum_tls_version                  = try(var.settings.minimum_tls_version, "1.2")
  public_network_access_enabled        = try(var.settings.public_network_access_enabled, true)
  outbound_network_restriction_enabled = try(var.settings.outbound_network_restriction_enabled, false)
  primary_user_assigned_identity_id    = try(var.settings.identity.primary_user_assigned_identity_key, null) != null ? try(var.managed_identities[var.settings.identity.primary_user_assigned_identity_key].id, null) : null
  tags                                 = local.tags

  dynamic "azuread_administrator" {
    for_each = lookup(var.settings, "azuread_administrator", {}) == {} ? [] : [1]

    content {
      login_username = try(var.settings.azuread_administrator.login_username, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].display_name, null)

      object_id = try(var.settings.azuread_administrator.object_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].object_id, null)

      tenant_id = try(var.settings.azuread_administrator.tenant_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].tenant_id, null)

      azuread_authentication_only = try(var.settings.azuread_administrator.azuread_authentication_only, null)
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, {}) == {} ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = concat(local.managed_identities, try(var.settings.identity.identity_ids, []))
    }
  }

}

resource "azurerm_mssql_server_transparent_data_encryption" "mssql" {
  count = try(var.settings.transparent_data_encryption, null) != null ? 1 : 0

  server_id = azurerm_mssql_server.mssql.id
  key_vault_key_id = try(var.settings.transparent_data_encryption.encryption_key, null) == null ? null : coalesce(
    try(var.key_vault_keys[var.settings.transparent_data_encryption.encryption_key.keyvault_key_key].id, null)
  )
}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  numeric          = true
  override_special = "$#%"
}

# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = can(var.settings.keyvault_secret_name) ? var.settings.keyvault_secret_name : format("%s-password", module.resource_naming.name_result)
  value        = random_password.sql_admin.0.result
  key_vault_id = try(var.key_vaults[var.settings.keyvault_key].id, null)

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
