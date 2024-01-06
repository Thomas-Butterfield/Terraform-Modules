# Used exclusively to generate multiple VMs using a count variable and VM name prefix
module "virtual_machine_groups" {
  source = "./modules/compute/virtual_machine_groups"
  for_each = {
    for key, value in try(local.settings.virtual_machine_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.named_vms, false) == false
  }

  global_settings    = local.settings
  settings           = each.value
  vm_count           = each.value.vm_count
  vm_name_prefix     = each.value.vm_name_prefix
  vm_admin_username  = var.vm_admin_username
  vm_admin_password  = var.vm_admin_password
  vm_domain_username = var.vm_domain_username
  vm_domain_password = var.vm_domain_password
  resource_groups    = local.resource_groups
  networking         = local.networking
  keyvaults          = local.keyvaults
  availability_sets  = module.availability_sets
  shared_images      = try(each.value.custom_id, module.shared_images)
  storage_account    = module.storage_account
  avd_host_pools     = module.avd_host_pools
  avzones            = try(each.value.zones, null)
}
# output "virtual_machine_groups_vms" {
#   value = { for virtual_machine in flatten([for groups in module.virtual_machine_groups : [for k, v in groups.virtual_machines_in_group : { "key" = k, "val" = v }]]) : virtual_machine.key => virtual_machine.val }
# }

# output "virtual_machines" {
#   value = local.virtual_machines
# }
