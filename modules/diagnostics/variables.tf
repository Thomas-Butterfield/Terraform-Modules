variable "global_settings" {
  description = "Global settings object"
  default     = {}
}
variable "diagnostics" {
  description = "Configuration settings object for the Azure Monitor Diagnostics resource"
}
variable "resource_id" {
  description = "The ID of an existing Resource on which to configure Diagnostic Settings (Fully Qualified Azure Resource ID)"
}
variable "resource_location" {
  description = "The resource location in which the referenced resource is created"
}
variable "profiles" {
  description = "Diagnostic profile map containing all the resoure profiles"

  validation {
    condition     = length(var.profiles) < 6
    error_message = "Maximun of 5 diagnostics profiles are supported."
  }
}
