variable "global_settings" {
  description = "Global settings object"
}
variable "ad_user" {
  description = "Configuration settings object for the AD User resource"
}
variable "key_vaults" {
  description = "Key Vaults module object"
  default     = {}
}
variable "password_policy" {
  description = "Map to define the password policy to apply"
  default = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    numeric = true

    # Define the number of days the password is valid. It must be more than the rotation frequency
    expire_in_days = 180
    rotation = {
      #
      # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
      # Only set one of the value
      #

      # mins   = 10     # recommended only for non-prod
      # days   = 7
      months = 1
    }
  }
}