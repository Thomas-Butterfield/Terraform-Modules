variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "bastion_host" {
  description = "Configuration settings object for the Bastion Host resource"
}
variable "bastion_subnet_id" {
  description = "Reference to a subnet in which this Bastion Host has been created (**Must be created in advance)"
  type        = string
}
variable "public_ip_address_id" {
  description = "Reference to a Public IP Address to associate with this Bastion Host (**Must be created in advance)"
  type        = string
}
