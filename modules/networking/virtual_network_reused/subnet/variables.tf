variable "global_settings" {
  description = "Global settings object"
}
variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "subnet" {
  description = "Configuration settings object for the Subnet resource"
}
variable "name" {
  description = "The name of the subnet used by the name mask or set explicitly for Azure defined subnet names such as AzureBastionSubnet, AzureFirewallSubnet, GatewaySubnet and RouteServerSubnet"
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet"
  type        = string
}
variable "address_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(string)
  default     = []
}
variable "private_endpoint_network_policies_enabled" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet. Default value is true. See Notes for more information: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#private_endpoint_network_policies_enabled"
  type        = bool
  default     = null
}
variable "private_link_service_network_policies_enabled" {
  description = "Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true. See Notes for more information: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#private_link_service_network_policies_enabled"
  type        = bool
  default     = null
}
variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web"
  type        = list(string)
  default     = ["Microsoft.KeyVault", "Microsoft.Storage"]
  # validation {
  #   condition     = var.service_endpoints == [] || contains(["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web"], var.service_endpoints)
  #   error_message = "Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  # }
}
