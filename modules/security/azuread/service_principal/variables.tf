variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "application_id" {
  description = "The application ID (client ID) of the application for which to create a service principal"
  type        = string
  default     = null
}
