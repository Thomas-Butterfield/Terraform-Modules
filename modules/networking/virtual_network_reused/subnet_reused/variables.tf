variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}

variable "subnet" {
  description = "Configuration settings object for the Subnet data resource"
}

variable "vnet_name" {
  description = "The name of the Virtual Network in which the resource is created"
  type        = string
}
