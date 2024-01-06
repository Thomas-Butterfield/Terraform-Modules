variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "vnet_peering" {
  description = "Configuration settings object for the Virtual Network Peering resource"
}
variable "virtual_network_name" {
  description = "The Name of the Virtual Network that will be peered with the remote VNet"
  type        = string
}
variable "remote_virtual_network_id" {
  description = "The ID of the Remote Virtual Network which the Virtual Network will be peered with"
  type        = string
}
variable "remote_virtual_network_name" {
  description = "The Name of the Remote Virtual Network to be used for naming the peering resource"
  type        = string
}
# variable "use_sharedsvc_provider" {
#   description = "Flag used to determine if sharedsvc_provider provider is used to build the resource"
#   type        = bool
#   default     = false
# }
