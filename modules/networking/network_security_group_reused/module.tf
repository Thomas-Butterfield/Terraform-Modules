locals {
  tags = merge(var.global_settings.tags, var.tags)
}

data "azurerm_network_security_group" "nsg_obj" {
  name                = var.network_security_group.name
  resource_group_name = try(var.network_security_group.rg_name, var.resource_group_name)
}
