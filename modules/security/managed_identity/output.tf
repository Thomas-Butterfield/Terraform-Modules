output "id" {
  description = "The ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.msi.id
}
output "name" {
  description = "The Name of the Managed Identity"
  value       = azurerm_user_assigned_identity.msi.name
}
output "principal_id" {
  description = "The Principal ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.msi.principal_id
}
output "client_id" {
  description = "The Client ID of the Managed Identity"
  value       = azurerm_user_assigned_identity.msi.client_id
}
output "rbac_id" {
  description = "The RBAC ID of the Managed Identity. This attribute is used to set the role assignment."
  value       = azurerm_user_assigned_identity.msi.principal_id
}
