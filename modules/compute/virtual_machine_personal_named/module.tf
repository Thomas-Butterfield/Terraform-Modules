
##==============================================================
## Name:    virtual_machine_groups
## Purpose: Module will generate multiple virtual machines
##          using a counter and vm_name_prefix
##          and apply the applicable VM extensions per VM.
##
## ** To create individual VMs, continue to use the 
##    virtual_machines.tf implementation
##==============================================================

module "virtual_machines_personal_named" {
  source = "../virtual_machine"

  for_each = var.settings.vm_count

  global_settings     = var.global_settings
  location            = try(var.settings.virtual_machine.location, null)
  settings            = var.settings.virtual_machine
  resource_group_name = var.resource_groups[var.settings.virtual_machine.resource_group_key].name
  tags                = try(var.settings.virtual_machine.tags, null)
  virtual_networks    = var.networking
  keyvaults           = var.keyvaults
  availability_sets   = var.availability_sets
  custom_image_ids    = var.shared_images
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  vm_count            = each.value
  vm_name_prefix      = var.vm_name_prefix
  zone                = try(element(var.avzones, "${each.value}"), null)
}

module "vm_group_vm_extension_AADLoginForWindows_named" {
  source     = "../virtual_machine_extensions"
  depends_on = [module.virtual_machines_personal_named]

  for_each = var.settings.virtual_machine_extensions.AADLoginForWindows.enabled == true ? var.settings.vm_count : {}

  virtual_machine_id = module.virtual_machines_personal_named[each.key].id
  extension          = var.settings.virtual_machine_extensions.AADLoginForWindows
  extension_name     = "AADLoginForWindows"
}

module "vm_group_vm_extension_LegacyADLoginForWindows_named" {
  source = "../virtual_machine_extensions"

  for_each = try(var.settings.virtual_machine_extensions.LegacyADLoginForWindows, null) != null && var.settings.virtual_machine_extensions.LegacyADLoginForWindows.enabled == true ? var.settings.vm_count : {}

  virtual_machine_id = module.virtual_machines_personal_named[each.key].id
  extension          = var.settings.virtual_machine_extensions.LegacyADLoginForWindows
  extension_name     = "LegacyADLoginForWindows"
  vm_domain_username = var.vm_domain_username != null ? var.vm_domain_username : try(var.settings.virtual_machine.virtual_machine_settings.windows.domain_username, null)
  vm_domain_password = var.vm_domain_password != null ? var.vm_domain_password : try(var.settings.virtual_machine.virtual_machine_settings.windows.domain_password, null)
}

module "vm_group_vm_extension_AVD_DSC_named" {
  source = "../virtual_machine_extensions"
  depends_on = [
    module.virtual_machines_personal_named,
    module.vm_group_vm_extension_AADLoginForWindows_named,
    module.vm_group_vm_extension_LegacyADLoginForWindows_named
  ]

  for_each = var.settings.virtual_machine_extensions.AVD_DSC_Extension.enabled == true ? var.settings.vm_count : {}

  virtual_machine_id = module.virtual_machines_personal_named[each.key].id
  extension          = var.settings.virtual_machine_extensions.AVD_DSC_Extension
  extension_name     = "AVD_DSC_Extension"
  avd_host_pools     = var.avd_host_pools
}

module "vm_group_vm_extension_AmdGpuDriverWindows" {
  source = "../virtual_machine_extensions"

  for_each = try(var.settings.virtual_machine_extensions.AmdGpuDriverWindows, null) != null && var.settings.virtual_machine_extensions.AmdGpuDriverWindows.enabled == true ? var.settings.vm_count : {}

  virtual_machine_id = module.virtual_machines_personal_named[each.key].id
  extension          = var.settings.virtual_machine_extensions.AmdGpuDriverWindows
  extension_name     = "AmdGpuDriverWindows"
}

module "vm_group_vm_extension_custom_script" {
  source     = "../virtual_machine_extensions"
  depends_on = [module.virtual_machines_personal_named]

  for_each = try(var.settings.virtual_machine_extensions.custom_script, null) != null && var.settings.virtual_machine_extensions.custom_script.enabled == true ? var.settings.vm_count : {}

  virtual_machine_id      = module.virtual_machines_personal_named[each.key].id
  virtual_machine_os_type = var.settings.virtual_machine.os_type
  extension               = var.settings.virtual_machine_extensions.custom_script
  extension_name          = "custom_script"
  storage_accounts        = var.storage_account
}