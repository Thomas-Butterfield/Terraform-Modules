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
variable "settings" {
  description = "Configuration settings object for the Load Balancer resource"
}
variable "subnet_id" {
  description = "The ID of the Subnet which should be associated with the IP Configuration"
  type        = string
  default     = null
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "gateway_fe_ip_id" {
  type    = string
  default = null
}
variable "public_ips" {
  description = "Public IP Addresses module object"
  default     = {}
}
variable "backend_resources" {
  description = "Backend Resources module object containing NIC resource ID"
  default     = {}
}
