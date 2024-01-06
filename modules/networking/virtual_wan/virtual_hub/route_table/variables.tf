variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the Virtual Hub Route Table resource"
}
variable "rt_table_key" {
  description = "Route Table Key Name from configuration settings"
  type        = string
}
variable "vhub" {
  description = "Virtual Hub module object"
}
variable "firewall_resource_id" {
  description = "Resource ID for the Virtual Hub Azure Firewall"
  type        = string
}
