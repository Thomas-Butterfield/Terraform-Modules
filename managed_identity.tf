module "managed_identity" {
  source = "./modules/security/managed_identity"
  for_each = {
    for key, value in try(local.settings.managedid, {}) : key => value
    if try(value.enabled, false) == true
  }
  managed_identity    = try(each.value)
  global_settings     = local.settings
  location            = try(each.value.location, null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}