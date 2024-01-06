variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "name" {
  description = "The name of the route. Changing this forces a new resource to be created."
  type        = string
}
variable "route_table_name" {
  description = "The name of the route table within which create the route"
  type        = string
}
variable "address_prefix" {
  description = "The destination CIDR to which the route applies, such as 10.1.0.0/16"
  type        = string
}
variable "next_hop_type" {
  description = "The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None"
  type        = string
  default     = "None"
  validation {
    condition     = contains(["VirtualNetworkGateway", "VnetLocal", "Internet", "VirtualAppliance", "None"], var.next_hop_type)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route#next_hop_type."
  }
}
variable "next_hop_in_ip_address" {
  description = "Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance"
  type        = string
  default     = null
}
