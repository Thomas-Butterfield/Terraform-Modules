
output "id" {
  description = "The ID of the user"
  value       = azuread_user.account.id
}

output "object_id" {
  description = "The object ID of the user"
  value       = azuread_user.account.object_id
}

output "rbac_id" {
  description = "The object ID of the user. This attribute is used to set the role assignment"
  value       = azuread_user.account.object_id
}

output "user_type" {
  description = "The user type in the directory. Possible values are Guest or Member"
  value       = azuread_user.account.user_type
}
