variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "private_endpoint" {
  description = "Configuration settings object for the Private Endpoint resource"
}
variable "resource_groups" {
  description = "Resource Groups module object"
}
variable "private_dns" {
  description = "Private DNS settings map object. Used only if already managing private DNS outside of this object."
  default     = {}
}
variable "remote_objects" {
  description = "Module objects used to retrieve IDs from var.private_endpoint keys"
}
variable "vnet" {
  description = "VNet module object - instance of specific VNet used for the Private Endpoint"
}