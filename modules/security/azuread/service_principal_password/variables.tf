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
variable "service_principal_id" {
  description = "(Required) The ID of the Service Principal for which this password should be created"
}
variable "service_principal_application_id" {
  description = "(Required) The App ID of the Application for which to create a Service Principal"
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
