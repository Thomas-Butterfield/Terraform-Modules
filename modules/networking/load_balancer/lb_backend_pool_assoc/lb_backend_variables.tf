variable "backend_address_pool_id" {
  description = "The ID of the Load Balancer Backend Address Pool which this Network Interface should be connected to"
  type        = string
}

variable "ip_configuration_name" {
  description = "The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool"
  type        = string
}

variable "network_interface_id" {
  description = "The ID of the Network Interface"
  type        = string
}
