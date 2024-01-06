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
variable "firewall_policy" {
  description = "Configuration settings object for the Azure Firewall Policy resource"

}
variable "base_policy_id" {
  description = "The ID of the base Firewall Policy"
  type        = string
  default     = null
}
