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
variable "ml_workspace" {
  description = "Configuration settings object for the Machine Learning Workspace"
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
variable "app_insights" {
  description = "Application Insights module object"
  default     = {}
}
