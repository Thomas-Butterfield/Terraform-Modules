variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "The naming convention settings object used to override defaults"
  default     = {}
}
variable "resource_type" {
  description = "Resource Type - to be used in any conditional evaluations in the module"
  type        = string
}
variable "name_mask" {
  description = "Naming convention taken either from the default resource local var or overridden per resource in settings"
  type        = string
  default     = null
}
variable "name" {
  description = "Set name outside of normal settings"
  type        = string
  default     = null
}
variable "referenced_name" {
  description = "Pass another objects name to the module to be associated or joined with current name"
  type        = string
  default     = null
}
variable "referenced_name_1" {
  description = "Pass another objects name to the module to be associated or joined with current name"
  type        = string
  default     = null
}
variable "object_name_prefix" {
  description = "Custom object name prefix used when overriding name_masks such as VMs"
  type        = string
  default     = null
}
variable "object_count" {
  description = "Custom object count used when overriding name_masks such as VMs"
  type        = number
  default     = 0
}
