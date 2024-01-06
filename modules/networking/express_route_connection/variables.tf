variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the Express Route Connection resource"
}
variable "express_route_circuit_peering_id" {
  description = "The ID of the Express Route Circuit Peering that this Express Route Connection connects with"
  type        = string
}
variable "express_route_gateway_id" {
  description = "The ID of the Express Route Gateway that this Express Route Connection connects with"
  type        = string
}
