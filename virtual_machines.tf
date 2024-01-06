module "virtual_machines_reused" {
  source = "./modules/compute/virtual_machine_reused"
  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings = local.settings
  settings        = each.value
}

module "virtual_machines" {
  source = "./modules/compute/virtual_machine"
  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  virtual_networks    = local.networking
  keyvaults           = local.keyvaults
  availability_sets   = module.availability_sets
  custom_image_ids    = try(each.value.custom_id)
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  zone                = try(each.value.zone, null)
}

module "availability_sets" {
  source = "./modules/compute/availability_set"
  for_each = {
    for key, value in try(local.settings.availability_sets, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  availability_set    = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "vm_extension_custom_script" {
  source = "./modules/compute/virtual_machine_extensions"
  depends_on = [
    module.virtual_machines,
  module.storage_account]

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
    && try(value.virtual_machine_extensions.custom_script, null) != null
    && try(value.virtual_machine_extensions.custom_script.enabled, false) == true
  }

  virtual_machine_id      = module.virtual_machines[each.key].id
  virtual_machine_os_type = each.value.os_type
  extension               = each.value.virtual_machine_extensions.custom_script
  extension_name          = "custom_script"
  storage_accounts        = module.storage_account
}

module "vm_extension_AADLoginForWindows" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
    && try(value.virtual_machine_extensions.AADLoginForWindows, null) != null
    && try(value.virtual_machine_extensions.AADLoginForWindows.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.AADLoginForWindows
  extension_name     = "AADLoginForWindows"
}

module "vm_extension_LegacyADLoginForWindows" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
    && try(value.virtual_machine_extensions.LegacyADLoginForWindows, null) != null
    && try(value.virtual_machine_extensions.LegacyADLoginForWindows.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.LegacyADLoginForWindows
  extension_name     = "LegacyADLoginForWindows"
  vm_domain_username = var.vm_domain_username != null ? var.vm_domain_username : try(each.value.virtual_machine_settings.windows.domain_username, null)
  vm_domain_password = var.vm_domain_password != null ? var.vm_domain_password : try(each.value.virtual_machine_settings.windows.domain_password, null)
}

module "vm_extension_AVD_DSC" {
  depends_on = [
    module.virtual_machines,
    module.avd_host_pools,
    module.vm_extension_AADLoginForWindows,
    module.vm_extension_LegacyADLoginForWindows
  ]
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
    && try(value.virtual_machine_extensions.AVD_DSC_Extension, null) != null
    && try(value.virtual_machine_extensions.AVD_DSC_Extension.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.AVD_DSC_Extension
  extension_name     = "AVD_DSC_Extension"
  avd_host_pools     = module.avd_host_pools
}

module "vm_extension_Promote_VM_DomainController" {
  source = "./modules/compute/virtual_machine_extensions"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
    && try(value.virtual_machine_extensions.Promote_VM_DomainController, null) != null
    && try(value.virtual_machine_extensions.Promote_VM_DomainController.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.Promote_VM_DomainController
  extension_name     = "Promote_VM_DomainController"
  vm_domain_username = var.vm_domain_username != null ? var.vm_domain_username : try(each.value.virtual_machine_settings.windows.domain_username, null)
  vm_admin_password  = var.vm_admin_password != null ? var.vm_admin_password : try(each.value.virtual_machine_settings.windows.admin_password, null)
}
