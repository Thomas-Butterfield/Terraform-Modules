output "id" {
  description = "The ID of the SQL Server Managed Instance Database"
  value       = azurerm_mssql_managed_database.sql_mi_db.id
}

output "name" {
  description = "The Name of the SQL Server Managed Instance Database"
  value       = azurerm_mssql_managed_database.sql_mi_db.name
}