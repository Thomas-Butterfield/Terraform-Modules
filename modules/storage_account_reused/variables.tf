variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "storage_account" {
  description = "Configuration settings object for the Storage Account resource"
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
  description = "Private DNS module object"
  default     = {}
}
