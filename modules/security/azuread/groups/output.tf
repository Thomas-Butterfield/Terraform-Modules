output "object_id" {
  description = "The Object ID of the Azure AD Group"
  value       = azuread_group.group.object_id
}

output "display_name" {
  description = "The name of the Azure AD Group"
  value       = azuread_group.group.display_name
}

output "tenant_id" {
  description = "The tenand_id of the Azure AD Group"
  value       = var.tenant_id
}
