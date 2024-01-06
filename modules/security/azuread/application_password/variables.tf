variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "client_config" {
  description = "Client configuration object from data.azurerm_client_config"
}
variable "keyvaults" {
  description = "Keyvaults module object"
  default     = {}
}
variable "application_client_id" {
  description = "The application ID (client ID) of the application for which this password should be created"
  type        = string
  default     = null
}
variable "application_object_id" {
  description = "The object ID of the application for which this password should be created"
  type        = string
  default     = null
}
variable "password_policy" {
  description = "Default password policy applies when not set in settings"
  default = {
    # Define the number of days the password is valid. It must be more than the rotation frequency
    expire_in_days = 180
    rotation = {
      #
      # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
      # Only set one of the value
      #

      # mins   = 10     # only recommended for CI and demo
      # days   = 7
      # months = 1
      years = 2
    }
  }
}
