variable "global_settings" {
  description = "Global settings object"
}

variable "settings" {
  description = "Configuration settings object for the Load Balancer Rule"
}

variable "loadbalancer_id" {
  description = "Load Balancer resource ID"
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "Load Balancer Frontend IP Configuration Name"
  type        = string
}

variable "backend_address_pool_ids" {
  description = " A list of reference to a Backend Address Pool over which this Load Balancing Rule operates"
  type        = list(string)
  default     = null
}

variable "probe_id" {
  description = "A reference to a Probe used by this Load Balancing Rule"
  type        = string
  default     = null
}
