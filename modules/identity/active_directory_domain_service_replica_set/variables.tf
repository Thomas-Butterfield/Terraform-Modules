variable "global_settings" {
  description = "Global settings object"
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "domain_service_id" {
  description = "The ID of the Domain Service for which to create this Replica Set"
  type        = string
  default     = null
}
