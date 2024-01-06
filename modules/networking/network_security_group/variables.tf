variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "network_security_group" {
  description = "Configuration settings object for the NSG definition resource"
}
variable "application_security_groups" {
  description = "Application Security Groups module object"
  default     = {}
}
variable "network_watchers" {
  description = "Network Watchers module object used by NSG Flow Logs"
  default     = {}
}
variable "diagnostics" {
  description = "Diagnostics object for the NSG Flow Logs resource"
  default     = {}
}
