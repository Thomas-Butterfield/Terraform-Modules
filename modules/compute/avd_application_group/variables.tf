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
variable "settings" {
  description = "Configuration settings object for the AVD Application Group resource"
}
variable "host_pool_id" {
  description = "Resource ID for an AVD Host Pool to associate with the AVD Application Group"
  type        = string
}
variable "workspace_id" {
  description = "The resource ID for the AVD Workspace"
  type        = string
}
