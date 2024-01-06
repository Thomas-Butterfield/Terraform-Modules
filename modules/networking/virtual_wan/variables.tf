variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "virtual_wan" {
  description = "Configuration settings object for the Virtual WAN resource"
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "public_ip_addresses" {
  description = "Public IP Addresses module object"
  default     = {}
}
