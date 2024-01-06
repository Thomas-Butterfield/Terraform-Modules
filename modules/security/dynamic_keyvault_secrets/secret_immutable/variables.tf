variable "name" {
  description = "Key Vault Secret Name"
  type        = string
}
variable "value" {
  description = "Key Vault Secret Value"
  type        = string
}
variable "keyvault_id" {
  description = "Key Vault resource ID used if ommitting var.keyvault_key and var.keyvaults"
  type        = string
}