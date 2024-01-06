# output "id" {
#   description = "The IDs of the Role Assignments"
#   value = merge(azurerm_role_assignment.object_id.*.id,
#     azurerm_role_assignment.azuread_apps.*.id,
#     azurerm_role_assignment.azuread_group.*.id,
#   azurerm_role_assignment.msi.*.id)
# }

# output "principal_type" {
#   description = "The type of the principal_id's, e.g. User, Group, Service Principal, Application, etc"
#   value = merge(azurerm_role_assignment.object_id.*.principal_type,
#     azurerm_role_assignment.azuread_apps.*.principal_type,
#     azurerm_role_assignment.azuread_group.*.principal_type,
#   azurerm_role_assignment.msi.*.principal_type)
# }
