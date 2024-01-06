variable "keyvaults" {
  description = "Key Vault module object used if omitting var.keyvault_id"
  default     = {}
}
variable "keyvault_id" {
  description = "Key Vault resource ID used if ommitting var.keyvault_key and var.keyvaults"
  type        = string
  default     = null
}
variable "access_policies" {
  description = "Access Policy map object"
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
  default     = null
}
variable "subscription_id" {
  description = "The Azure Subscription ID used to explicitly provide access at the subscription level"
  type        = string
  default     = null
}
variable "object_id" {
  description = "Object ID used to provide access to a specific Azure resource"
  type        = string
  default     = null
}
variable "managed_identities" {
  description = "Managed Identity module object"
  default     = {}
}
