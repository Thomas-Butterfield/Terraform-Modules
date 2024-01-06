output "id" {
  description = "The ID of the SQL Server Database"
  value       = azurerm_mssql_database.mssql_db.id
}

output "name" {
  description = "The Name of the SQL Server Database"
  value       = azurerm_mssql_database.mssql_db.name
}