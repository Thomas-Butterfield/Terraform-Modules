variable "settings" {
  description = "Configuration settings object for the Storage Blob resource"
}
variable "storage_account_name" {
  description = "Specifies the storage account in which to create the storage container"
  type        = string
}
variable "storage_container_name" {
  description = "The name of the storage container in which this blob should be created"
  type        = string
}
