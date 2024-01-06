module "storage_account" {
  source = "./modules/storage_account"
  for_each = {
    for key, value in try(local.settings.storageaccounts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  storage_account     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  virtual_networks    = local.networking
  tags                = try(each.value.tags, null)
}
