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
variable "virtual_hub" {
  description = "Configuration settings object for the Virtual Hub resource"
}
variable "vwan_id" {
  description = "Resource ID for the Virtual WAN object"
  type        = string
}
variable "virtual_networks" {
  description = "Virtual Networks module object"

}
variable "public_ip_addresses" {
  description = "Public IP Addresses module object"
}
