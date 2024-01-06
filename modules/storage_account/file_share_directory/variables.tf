variable "settings" {
  description = "Configuration settings object for the Storage File Share resource"
}
variable "storage_account_name" {
  description = "Specifies the storage account in which to create the resource"
  type        = string
}
variable "share_name" {
  description = "The name of the File Share where this Directory should be created"
  type        = string
}
