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
  description = "Configuration settings object for the Virtual Network Gateway Connection resource"
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global_settings.location."
  type        = string
  default     = null
}
variable "virtual_network_gateway_id" {
  description = "The ID of the Virtual Network Gateway in which the connection will be created"
  type        = string
}
variable "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit when creating an ExpressRoute connection (i.e. when type is ExpressRoute). The Express Route Circuit can be in the same or in a different subscription."
  type        = string
  default     = null
}
variable "express_route_authorization_key" {
  description = "The authorization key associated with the Express Route Circuit. This field is required only if the type is an ExpressRoute connection."
  type        = string
  default     = null
}
variable "peer_virtual_network_gateway_id" {
  description = "The ID of the peer virtual network gateway when creating a VNet-to-VNet connection (i.e. when type is Vnet2Vnet). The peer Virtual Network Gateway can be in the same or in a different subscription."
  type        = string
  default     = null
}
variable "local_network_gateway_id" {
  description = "The ID of the local network gateway when creating Site-to-Site connection (i.e. when type is IPsec)."
  type        = string
  default     = null
}
