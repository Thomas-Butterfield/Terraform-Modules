variable "global_settings" {
  description = "Global settings object"
}
variable "vhub_connection" {
  description = "Configuration settings object for the Virtual Hub Connection resource"
}
variable "virtual_hub" {
  description = "Virtual Hub module object"
}
variable "virtual_network_id" {
  description = "The ID of the Virtual Network which the Virtual Hub should be connected to"
  type        = string
}
variable "vnet_address_space" {
  description = "The Address Space of the Virtual Network - used for the naming object"
  type        = list(string)
}
variable "virtual_hub_id" {
  description = "The ID of the Virtual Hub within which this connection should be created (**Set when not using data resource)"
  type        = string
  default     = null
}
variable "virtual_hub_as_data" {
  description = "Flag used to determine if vhub_subscription provider is used to build the resource"
  type        = bool
  default     = false
}
