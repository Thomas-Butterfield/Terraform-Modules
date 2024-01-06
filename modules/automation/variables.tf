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
variable "automation_account" {
  description = "Configuration settings object for the Automation Account"
}
variable "sku_name" {
  description = "The SKU name of the account - only Basic is supported at this time. Defaults to Basic"
  type        = string
  default     = "Basic"
}
variable "log_analytics" {
  description = "Log Analytics module object"
  default     = {}
}
