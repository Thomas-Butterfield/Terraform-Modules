variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the AVD Application resource"
}
variable "application_group_id" {
  description = "Resource ID for a AVD Application Group to associate with the AVD Application"
  type        = string
}
