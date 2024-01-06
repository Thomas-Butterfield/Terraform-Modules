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
variable "firewall" {
  description = "Configuration settings object for the Firewall resource"
}
variable "subnet_id" {
  description = "(VHUB=Optional/HubSpoke=Required) Reference to a subnet in which this Firewall will be created (**Must be created in advance)"
  default     = null
}
variable "public_ip_id" {
  description = "Public IP address identifier. IP address must be of type static and standard"
  default     = null
}
variable "public_ip_addresses" {
  description = "Public IP addresses module object (**Only required if not attaching to Virtual Hub)"
  default     = {}
}
variable "virtual_wans" {
  description = "Virtual WAN module object (**Only required if attaching to Virtual Hub and if not providing var.virtual_hubs)"
  default     = {}
}
variable "virtual_hubs" {
  description = "Virtual Hub module object (**Only required if attaching to Virtual Hub)"
  default     = {}
}
variable "virtual_networks" {
  description = "Virtual Networks module object (**Only required if not attaching to Virtual Hub)"
  default     = {}
}
variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy applied to this Firewall"
  type        = string
  default     = null
}
