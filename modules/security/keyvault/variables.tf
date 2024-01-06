variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "key_vault" {
  description = "Configuration settings object for the Key Vault resource"
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "private_endpoints" {
  description = "Private Endpoints map settings object"
  default     = {}
}
variable "private_dns" {
  description = "Managed Identities module object"
  default     = {}
}