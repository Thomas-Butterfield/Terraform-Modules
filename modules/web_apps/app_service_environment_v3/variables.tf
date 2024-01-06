variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
}
