variable "global_settings" {
  description = "Global settings object"
}

variable "settings" {
  description = "Configuration settings object for the Load Balancer NAT Rule"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}

variable "loadbalancer_id" {
  description = "Load Balancer resource ID"
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "Load Balancer Frontend Configuration Name"
  type        = string
}

variable "backend_address_pool_id" {
  description = "Load Balancer Backend Address Pool resource ID"
  type        = string
}
