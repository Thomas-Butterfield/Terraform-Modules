output "id" {
  description = "The ID of the Data Resource Group"
  value       = data.azurerm_resource_group.rg.id
}

output "name" {
  description = "The Name of the Data Resource Group"
  value       = data.azurerm_resource_group.rg.name
}

output "location" {
  description = "The Location of the Data Resource Group"
  value       = data.azurerm_resource_group.rg.location
}

output "tags" {
  description = "The Tags of the Data Resource Group"
  value       = data.azurerm_resource_group.rg.tags
}
