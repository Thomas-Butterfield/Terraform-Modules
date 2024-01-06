output "id" {
  description = "The ID of the SQL Server"
  value       = azurerm_mssql_server.mssql.id
}

output "name" {
  description = "The Name of the SQL Server"
  value       = azurerm_mssql_server.mssql.name
}

output "fully_qualified_domain_name" {
  description = "The FQDN of the SQL Server"
  value       = azurerm_mssql_server.mssql.fully_qualified_domain_name
}

output "rbac_id" {
  description = "The RBAC ID (Principal ID) of the SQL Server"
  value       = try(azurerm_mssql_server.mssql.identity[0].principal_id, null)
}

output "identity" {
  description = "The Identity block of the SQL Server"
  value       = try(azurerm_mssql_server.mssql.identity, null)
}

output "azuread_administrator" {
  description = "The Azure AD Administrator of the SQL Server"
  value       = try(azurerm_mssql_server.mssql.azuread_administrator, null)
}
