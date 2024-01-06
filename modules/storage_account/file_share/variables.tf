variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "settings" {
  description = "Configuration settings object for the Storage File Share resource"
}
variable "storage_account_name" {
  description = "Specifies the storage account in which to create the resource"
  type        = string
}
variable "storage_account_id" {
  description = "Specifies the ID of the Storage Account in which the File Share should exist"
  type        = string
}
variable "recovery_vault" {
  description = "Recovery Vault module object"
  default     = {}
}
