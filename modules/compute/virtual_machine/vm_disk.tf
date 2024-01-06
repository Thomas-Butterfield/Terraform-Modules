locals {
  datadisk_name_mask = "{referenced_name}{delimiter}{datadisk}{delimiter}{postfix}"
}

module "resource_naming_datadisk_name" {
  source   = "../../resource_naming"
  for_each = lookup(var.settings, "data_disks", {})

  global_settings = var.global_settings
  settings        = each.value
  resource_type   = "azurerm_managed_disk"
  name            = try(each.value.name, null)
  name_mask       = try(each.value.naming_convention.name_mask, local.datadisk_name_mask)
  referenced_name = local.os_type == "linux" ? module.resource_naming_linux_vm_name[each.value.vm_setting_key].name_result : local.os_type == "windows" ? module.resource_naming_windows_vm_name[each.value.vm_setting_key].name_result : module.resource_naming_legacy_vm_name[each.value.vm_setting_key].name_result
}

resource "azurerm_managed_disk" "disk" {
  for_each = lookup(var.settings, "data_disks", {})

  name                   = module.resource_naming_datadisk_name[each.key].name_result
  location               = var.location != null ? var.location : var.global_settings.location
  resource_group_name    = var.resource_group_name
  storage_account_type   = each.value.storage_account_type
  create_option          = each.value.create_option
  disk_size_gb           = each.value.disk_size_gb
  zone                   = try(each.value.zone, null)
  disk_iops_read_write   = try(each.value.disk_iops_read_write, null)
  disk_mbps_read_write   = try(each.value.disk.disk_mbps_read_write, null)
  tags                   = local.tags
  disk_encryption_set_id = try(each.value.disk_encryption_set_key, null) == null ? null : var.disk_encryption_sets[each.value.disk_encryption_set_key].id

  lifecycle {
    ignore_changes = [
      name, resource_group_name, location
    ]
  }

}

resource "azurerm_virtual_machine_data_disk_attachment" "disk" {
  for_each = lookup(var.settings, "data_disks", {})

  managed_disk_id = coalesce(
    try(each.value.restored_disk_id, null),
    try(azurerm_managed_disk.disk[each.key].id, null)
  )
  virtual_machine_id        = local.os_type == "linux" ? azurerm_linux_virtual_machine.vm["linux"].id : local.os_type == "windows" ? azurerm_windows_virtual_machine.vm["windows"].id : azurerm_virtual_machine.vm["legacy"].id
  lun                       = each.value.lun
  caching                   = lookup(each.value, "caching", "None")
  write_accelerator_enabled = lookup(each.value, "write_accelerator_enabled", false)

}
