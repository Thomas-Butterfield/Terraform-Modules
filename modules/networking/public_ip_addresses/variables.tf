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
variable "public_ip_address" {
  description = "Configuration settings object for the Public IP Address resource"
}
variable "public_ip_prefix_id" {
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource"
  type        = string
  default     = null
}
