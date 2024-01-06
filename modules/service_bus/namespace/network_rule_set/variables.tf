variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "servicebus_namespace_id" {
  description = "ServiceBus Namespace ID"
  type        = string
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
