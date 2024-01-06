resource "azurerm_mssql_server_security_alert_policy" "mssql" {
  count = try(var.settings.security_alert_policy, null) == null ? 0 : 1

  resource_group_name        = var.resource_group_name
  server_name                = azurerm_mssql_server.mssql.name
  state                      = try(var.settings.state, "Enabled")
  disabled_alerts            = try(var.settings.disabled_alerts, null)
  email_account_admins       = try(var.settings.email_subscription_admins, false)
  email_addresses            = try(var.settings.email_addresses, null)
  retention_days             = try(var.settings.retention_days, 0)
  storage_endpoint           = try(var.storage_accounts[var.settings.security_alert_policy.sa_key].primary_blob_endpoint, null)
  storage_account_access_key = try(var.storage_accounts[var.settings.security_alert_policy.sa_key].primary_access_key, null)
}