output "id" {
  description = "This ID is specific to Terraform - and is of the format {roleDefinitionId}|{scope}"
  value       = azurerm_role_definition.custom_role.id
}
output "name" {
  description = "The Name of the custom role definition"
  value       = azurerm_role_definition.custom_role.name
}
output "role_definition_id" {
  description = "The Role Definition ID"
  value       = azurerm_role_definition.custom_role.role_definition_id
}
output "role_definition_resource_id" {
  description = "The Azure Resource Manager ID for the resource"
  value       = azurerm_role_definition.custom_role.role_definition_resource_id
}
