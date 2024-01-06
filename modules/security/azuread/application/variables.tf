variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "client_config" {
  description = "Client configuration object from data.azurerm_client_config"
}
variable "azuread_api_permissions" {
  default = {}
}
