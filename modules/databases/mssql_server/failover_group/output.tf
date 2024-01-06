output "id" {
  description = "The ID of the Failover Group"
  value       = azurerm_mssql_failover_group.failover_group.id
}

output "name" {
  description = "The Name of the Failover Group"
  value       = azurerm_mssql_failover_group.failover_group.name
}

output "partner_server" {
  description = "The Partner Server block of the Failover Group"
  value       = azurerm_mssql_failover_group.failover_group.partner_server
}
