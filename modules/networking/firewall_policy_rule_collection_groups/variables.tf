variable "global_settings" {
  description = "Global settings object"
}
variable "policy_settings" {
  description = "Configuration settings object for the Azure Firewall Policy resource"
}
variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist"
  type        = string
}
variable "ip_groups" {
  description = "IP groups module object"
  default     = {}
}
variable "public_ip_addresses" {
  description = "Public IP addresses module object"
  default     = {}
}
