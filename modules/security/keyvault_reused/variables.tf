variable "global_settings" {
  description = "Global settings object"
}
variable "key_vault" {
  description = "Configuration settings object for the Key Vault resource"
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}
