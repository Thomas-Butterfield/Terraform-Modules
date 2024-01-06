variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "mssql_server_id" {
  description = "MS SQL Server Resource ID"
  type        = string
}
variable "primary_mssql_server_id" {}
variable "secondary_mssql_server_id" {}
variable "databases" {}