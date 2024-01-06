output "id" {
  description = "The ID of the SQL Server Network Rule"
  value       = azurerm_mssql_virtual_network_rule.mssql.id
}
output "name" {
  description = "The Name of the SQL Server Network Rule"
  value       = azurerm_mssql_virtual_network_rule.mssql.name
}
