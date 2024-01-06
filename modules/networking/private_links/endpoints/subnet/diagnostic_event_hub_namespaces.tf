module "diagnostic_event_hub_namespaces" {
  source   = "../private_endpoint"
  for_each = try(var.private_endpoints.diagnostic_event_hub_namespaces, {})

  global_settings     = var.global_settings
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  private_dns         = var.private_dns
  resource_group_name = try(var.resource_groups[each.value.resource_group_key].name, var.vnet_resource_group_name)
  resource_id         = can(each.value.resource_id) ? each.value.resource_id : var.remote_objects.diagnostic_event_hub_namespaces[try(each.value.diagnostic_event_hub_namespace_key, each.key)].id
  resource_name       = can(each.value.resource_name) ? each.value.resource_name : var.remote_objects.diagnostic_event_hub_namespaces[try(each.value.diagnostic_event_hub_namespace_key, each.key)].name
  settings            = each.value
  subnet_id           = var.subnet_id
  vnet_id             = var.vnet_id
  subresource_name    = "namespace"
  tags                = var.tags
}