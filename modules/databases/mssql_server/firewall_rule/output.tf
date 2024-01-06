output "id" {
  description = "The ID of the SQL Server Firewall Rule"
  value       = azurerm_mssql_firewall_rule.mssql.id
}
output "name" {
  description = "The Name of the SQL Server Firewall Rule"
  value       = azurerm_mssql_firewall_rule.mssql.name
}
