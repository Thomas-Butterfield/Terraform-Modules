variable "azuread_group" {
  description = "Azure AD Group settings object"
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID where the AD Groups will be provisioned"
  type        = string
  default     = null
}
variable "client_config" {
  description = "Client configuration object from data.azurerm_client_config"
  default     = null
}