output "id" {
  description = "The ID of the Data Factory"
  value       = azurerm_data_factory.df.id
}

output "name" {
  description = "The Name of the Data Factory"
  value       = azurerm_data_factory.df.name
}

output "identity" {
  description = "The Identity block of the Data Factory"
  value       = azurerm_data_factory.df.identity
}
