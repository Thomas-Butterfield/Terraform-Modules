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
variable "mssql_servers" {
  description = "MSSQL Servers module object"
}
variable "mssql_elastic_pools" {
  description = "MSSQL Servers Elastic Pools module object"
}
