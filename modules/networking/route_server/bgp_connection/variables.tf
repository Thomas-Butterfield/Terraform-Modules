variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "route_server_id" {
  description = "The ID of the Route Server within which this Bgp connection should be created"
  type        = string
}
