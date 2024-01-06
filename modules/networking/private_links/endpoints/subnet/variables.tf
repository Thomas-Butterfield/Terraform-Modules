variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "resource_groups" {
  description = "Resource Groups module object"
}
variable "private_endpoints" {
  description = "Private Endpoints configuration settings map"
}
variable "private_dns" {
  description = "Private DNS settings map object"
}
variable "remote_objects" {
  description = "Resource ID map of remote objects"
}
variable "subnet_id" {
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint"
  type        = string
}
variable "vnet_id" {
  description = "The ID of the VNet"
  type        = string
}
variable "vnet_resource_group_name" {
  description = "The Resource Group Name of the VNet"
  type        = string
}
variable "vnet_location" {
  description = "The Location of the VNet"
  type        = string
}