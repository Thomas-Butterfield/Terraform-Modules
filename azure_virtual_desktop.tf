
module "avd_host_pools" {
  source = "./modules/compute/avd_host_pool"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.host_pools, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "avd_scaling_plans" {
  depends_on = [
    module.roles
  ]
  source = "./modules/compute/avd_scaling_plan"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.scaling_plans, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  avd_host_pools      = module.avd_host_pools
  tags                = try(each.value.tags, null)
}

module "avd_workspaces" {
  source = "./modules/compute/avd_workspace"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.workspaces, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "avd_app_groups" {
  source = "./modules/compute/avd_application_group"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.application_groups, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  host_pool_id        = module.avd_host_pools[each.value.host_pool_key].id
  workspace_id        = module.avd_workspaces[each.value.workspace_key].id
}

module "avd_applications" {
  source = "./modules/compute/avd_applications"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.applications, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings      = local.settings
  settings             = each.value
  application_group_id = module.avd_app_groups[each.value.app_group_key].id
}
