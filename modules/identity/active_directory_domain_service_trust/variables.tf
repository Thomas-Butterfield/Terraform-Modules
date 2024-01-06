variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "domain_service_id" {
  description = "The ID of the Domain Service for which to create this Replica Set"
  type        = string
  default     = null
}
variable "password" {
  description = "The password of the inbound trust set in the on-premise Active Directory Domain Service"
  type        = string
  default     = null
}
