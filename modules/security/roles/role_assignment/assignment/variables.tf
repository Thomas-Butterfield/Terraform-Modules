variable "scope" {
  description = "The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG"
  type        = string
}
variable "role_definition_name" {
  description = "Role Mappings key name if built-in, otherwise null"
  default     = null
}
variable "role_definition_id" {
  description = "custom_roles module object role_definition_resource_id value or null if not custom role"
  default     = null
}
variable "keys" {
  description = "Role Mappings object"
}
variable "azuread_apps" {
  description = "Azure AD Apps module object"
  default     = {}
}
variable "azuread_service_principals" {
  description = "Azure AD Service Principals module object"
  default     = {}
}
variable "azuread_groups" {
  description = "Azure AD Groups module object"
  default     = {}
}
variable "managed_identities" {
  description = "Managed Identities module object"
  default     = {}
}
variable "client_config" {
  description = "Client configuration object from data.azurerm_client_config"
  default     = null
}