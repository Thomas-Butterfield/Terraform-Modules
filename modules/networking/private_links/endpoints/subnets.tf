locals {
  tags = merge(var.global_settings.tags, var.tags, try(var.private_endpoint.tags, null))
}

module "subnet" {
  source   = "./subnet"
  for_each = toset(try(var.private_endpoint.subnet_keys, []))

  global_settings          = var.global_settings
  resource_groups          = var.resource_groups
  private_endpoints        = var.private_endpoint
  private_dns              = var.private_dns
  vnet_resource_group_name = var.vnet.resource_group_name
  vnet_location            = var.vnet.location
  vnet_id                  = var.vnet.id
  subnet_id                = var.vnet.subnets[each.key].id
  remote_objects           = var.remote_objects
  tags                     = local.tags
}

output "subnet" {
  value = module.subnet
}
