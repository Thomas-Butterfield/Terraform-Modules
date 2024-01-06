variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created. Default to network_security_group.rg_name"
  type        = string
  default     = null
}
variable "network_security_group" {
  description = "Configuration settings object for the NSG definition resource"
}
variable "network_watchers" {
  description = "Network Watchers module object used by NSG Flow Logs"
  default     = {}
}
variable "diagnostics" {
  description = "Diagnostics object for the NSG Flow Logs resource"
  default     = {}
}
