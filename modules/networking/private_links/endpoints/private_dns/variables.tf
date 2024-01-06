variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "settings" {
  description = "Configuration settings object for the Private DNS resource"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "records" {
  description = "Hardcoded Private IP Address list"
  default     = {}
}
variable "private_ip_addresses" {
  description = "Private Endpoint Module object Private IP Address list"
  type        = list(string)
  default     = []
}
variable "vnet_id" {
  description = "The ID of the Virtual Network to be used for Private DNS VNET Link"
  type        = string
}
variable "resource_name" {
  description = "The Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to"
  type        = string
  default     = null
}
