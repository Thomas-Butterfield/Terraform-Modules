variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "settings" {
  description = "Configuration settings object for the Express Route Circuit Peering resource"
}
variable "express_route_circuit_name" {
  description = "The name of the ExpressRoute Circuit in which to create the Peering"
  type        = string
}
