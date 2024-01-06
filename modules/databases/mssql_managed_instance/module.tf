
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{mssql_mi}{delimiter}{postfix}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_mssql_managed_instance"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_mssql_managed_instance" "sql_mi" {
  name                         = module.resource_naming.name_result
  location                     = var.location != null ? var.location : var.global_settings.location
  resource_group_name          = var.resource_group_name
  administrator_login          = var.settings.administrator_login
  administrator_login_password = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
  license_type                 = try(var.settings.license_type, null)
  sku_name                     = try(var.settings.sku_name, null)
  storage_size_in_gb           = try(var.settings.storage_size_in_gb, null)
  subnet_id = coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  )
  vcores                         = try(var.settings.vcores, null)
  collation                      = try(var.settings.collation, "SQL_Latin1_General_CP1_CI_AS")
  dns_zone_partner_id            = try(var.settings.dns_zone_partner_id, null)
  maintenance_configuration_name = try(var.settings.maintenance_configuration_name, null)
  minimum_tls_version            = try(var.settings.minimum_tls_version, "1.2")
  proxy_override                 = try(var.settings.proxy_override, null)
  public_data_endpoint_enabled   = try(var.settings.public_data_endpoint_enabled, false)
  storage_account_type           = try(var.settings.storage_account_type, "GRS")
  timezone_id                    = try(var.settings.timezone_id, "UTC")
  tags                           = local.tags

  dynamic "identity" {
    for_each = try(var.settings.identity, {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "sql_mi" {
  count = try(var.settings.active_directory_administrator, null) == null ? 0 : 1

  managed_instance_id = azurerm_mssql_managed_instance.sql_mi.id

  login_username = try(var.settings.active_directory_administrator.login_username, var.azuread_groups[var.settings.active_directory_administrator.azuread_group_key].display_name, null)

  object_id = try(var.settings.active_directory_administrator.object_id, var.azuread_groups[var.settings.active_directory_administrator.azuread_group_key].object_id, null)

  tenant_id = try(var.settings.active_directory_administrator.tenant_id, var.azuread_groups[var.settings.active_directory_administrator.azuread_group_key].tenant_id, null)

  azuread_authentication_only = try(var.settings.active_directory_administrator.azuread_authentication_only, null)
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
