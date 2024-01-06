variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "express_route_circuit_name" {
  description = " The name of the Express Route Circuit in which to create the Authorization"
  type        = string
}
