output "id" {
  description = "The ID of the SQL Server Managed Instance"
  value       = azurerm_mssql_managed_instance.sql_mi.id
}

output "name" {
  description = "The ID of the SQL Server Managed Instance"
  value       = azurerm_mssql_managed_instance.sql_mi.name
}

output "fqdn" {
  description = "The FQDN of the SQL Server Managed Instance"
  value       = azurerm_mssql_managed_instance.sql_mi.fqdn
}

output "rbac_id" {
  description = "The RBAC ID (Principal ID) of the SQL Server Managed Instance"
  value       = try(azurerm_mssql_managed_instance.sql_mi.identity[0].principal_id, null)
}

output "identity" {
  description = "The Identity block of the SQL Server Managed Instance"
  value       = try(azurerm_mssql_managed_instance.sql_mi.identity, null)
}

output "sqlmi_azuread_administrator_id" {
  description = "The ID of the SQL Managed Instance Active Directory Administrator"
  value       = try(azurerm_mssql_managed_instance_active_directory_administrator.sql_mi[0].id, null)
}
