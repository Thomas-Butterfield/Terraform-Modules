variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the Express Route Connection resource"
}
variable "peering_id" {
  description = "The ID of the Express Route Circuit Private Peering that this Express Route Circuit Connection connects with"
  type        = string
}
variable "peer_peering_id" {
  description = "The ID of the peered Express Route Circuit Private Peering"
  type        = string
}
