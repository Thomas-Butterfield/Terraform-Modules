variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "servicebus_topic_id" {
  description = "ServiceBus Topic ID"
  type        = string
}
variable "servicebus_queues" {
  description = "ServiceBus Queues module object for forwarded messsages property"
  default     = {}
}
variable "servicebus_topics" {
  description = "ServiceBus Topics module object for forwarded messsages property"
  default     = {}
}