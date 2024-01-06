variable "settings" {
  description = "Configuration settings object for the Key Vault Secret Key resource"
}
variable "keyvault_id" {
  description = "Key Vault resource ID"
  type        = string
}
variable "objects" {
  description = "Key Vault Secret values map object"
  default     = {}
}
