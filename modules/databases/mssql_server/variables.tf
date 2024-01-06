variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "managed_identities" {
  description = "Managed Identity module object"
  default     = {}
}
variable "key_vaults" {
  description = "Key Vaults module object"
  default     = {}
}
variable "key_vault_keys" {
  description = "Key Vault Keys module object"
  default     = {}
}
variable "storage_accounts" {
  description = "Storage Accounts module object"
  default     = {}
}
variable "azuread_groups" {
  description = "Azure AD Groups module object"
  default     = {}
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "resource_groups" {
  description = "Resource Groups module object"
  default     = {}
}
