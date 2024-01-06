variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "servicebus_queue_id" {
  description = "ServiceBus Queue ID"
  type        = string
}
