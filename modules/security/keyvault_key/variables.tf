variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "settings" {
  description = "Configuration settings object for the Keyvault Key resource"
}
variable "keyvault_id" {
  description = "Key Vault resource ID"
}
