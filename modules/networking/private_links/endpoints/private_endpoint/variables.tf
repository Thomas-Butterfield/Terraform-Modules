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
variable "settings" {
  description = "Configuration settings object for the Private Endpoint resource"
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global_settings.location."
  type        = string
  default     = null
}
variable "resource_id" {
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to"
  type        = string
}
variable "resource_name" {
  description = "The Name of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to"
  type        = string
  default     = null
}
variable "subnet_id" {
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint"
  type        = string
}
variable "vnet_id" {
  description = "The ID of the Virtual Network to be used for Private DNS VNET Link"
  type        = string
}
variable "subresource_name" {
  description = "Private Endpoint Service Connection Sub Resource Name"
  type        = string
}
variable "private_dns" {
  description = "Private DNS settings map object"
  default     = {}
}