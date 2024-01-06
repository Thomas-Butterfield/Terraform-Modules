variable "keyvault_id" {
  description = "Key Vault ID used to provide access to a specific Azure resource"
  type        = string
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}
variable "object_id" {
  description = "Object ID used to provide access to a specific Azure resource"
  type        = string
}
variable "access_policy" {
  description = "Access Policy configuration settings object"
}
