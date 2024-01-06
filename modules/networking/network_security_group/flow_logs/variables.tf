variable "global_settings" {
  description = "Global settings object"
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "settings" {
  description = "Configuration settings object for the NSG Flow Logs resource"
  default     = {}
}
variable "resource_id" {
  description = "Fully qualified Azure resource identifier for which you enable diagnostics"
  type        = string
}
variable "nsg_name" {
  description = "NSG Name that will be used as a default name for the NSG Flow Log"
  type        = string
}
variable "network_watchers" {
  description = "Network Watcher module object"
  default     = {}
}
variable "diagnostics" {
  description = "Diagnostics object for the NSG Flow Logs resource"
  default     = {}
}
