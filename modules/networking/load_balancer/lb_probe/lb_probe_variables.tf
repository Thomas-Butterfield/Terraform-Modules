variable "global_settings" {
  description = "Global settings object"
}

variable "settings" {
  description = "Configuration settings object for the Load Balancer Probe"
}

variable "loadbalancer_id" {
  description = "Load Balancer resource ID"
  type        = string
}

## 'Http', 'Https', 'Tcp' or ''
variable "lb_probe_protocol" {
  default = null
}

variable "lb_probe_uri" {
  default = "/"
  type    = string
}

variable "lb_probe_interval" {
  default = 15
}

variable "lb_failed_probes" {
  default = 2
}
