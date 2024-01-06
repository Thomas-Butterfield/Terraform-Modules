
module "resource_groups" {
  source = "./modules/resource_group"
  for_each = {
    for key, value in try(local.settings.resource_groups, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  resource_group_name = each.value.name
  resource_group      = each.value
  global_settings     = local.settings
  location            = try(each.value.location, null)
  tags                = try(each.value.tags, null)
}

module "resource_group_reused" {
  source = "./modules/resource_group_reused"
  for_each = {
    for key, value in try(local.settings.resource_groups, {}) : key => value
    if try(value.reuse, false) == true && try(value.named_vms, false) == true
  }

  settings = each.value
}

# output "resource_groups" {
#   value = local.resource_groups
# }
