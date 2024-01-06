module "private_endpoints" {
  source = "./modules/networking/private_links/endpoints"
  for_each = {
    for key, value in try(local.settings.networking.private_endpoints, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings  = local.settings
  private_endpoint = each.value
  resource_groups  = local.resource_groups
  vnet             = local.networking[each.value.vnet_key]
  tags             = try(each.value.tags, null)

  remote_objects = local.privendpoint_remote_objects

}
