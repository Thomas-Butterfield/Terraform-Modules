variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "recovery_vault" {
  description = "Configuration settings object for the Recovery Vault resource"
}
variable "sku" {
  description = "The sku which in theory should default between GRS and LRS, but Microsoft does not seem to have this well documented. Possible values are Standard, RS0. Defaults to Standard"
  default     = "Standard"
  type        = string

  validation {
    condition     = contains(["Standard", "RS0"], var.sku)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault#sku."
  }
}
variable "private_endpoints" {
  description = "Private Endpoints module object"
  default     = {}
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "private_dns" {
  description = "Private DNS module object"
  default     = {}
}
