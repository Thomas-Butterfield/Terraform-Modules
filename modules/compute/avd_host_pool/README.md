# Azure Virtual Desktop Host Pool

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"

Example Result: AVA-EUS2-DEV-AVD-HOSTPOOL
```

## Example Settings
```yaml
azure_virtual_desktops:
  host_pools:
    hostpool1:
      enabled: true
      resource_group_key: "avd"
      name: "HOSTPOOL"
      type: "Pooled"
      load_balancer_type: "BreadthFirst"
      friendly_name: "AVD Host Pool"
      registration_info:
        rotation_days: 30
      scheduled_agent_updates:
        au1:
          enabled: true
          timezone: "Eastern Standard Time"
          schedule:
            sched1:
              day_of_week: "Saturday"
              hour_of_day: "2"

## Virtual Machine Host Pool Example
virtual_machines:
  vm1:
    resource_group_key: "avd"
    os_type: windows
    enabled: true
    provision_vm_agent: true
    keyvault_key: "kv1"

    network_interfaces:
      nic0:
        vm_setting_key: "windows"
        vnet_key: "vnet1"
        subnet_key: "subnet1"
        primary: true
        naming_convention:
          postfix: "01"
        enable_ip_forwarding: false

    virtual_machine_settings:
      windows:
        naming_convention:
          name_mask: "{name}"
        name: "AVD-TEST-VM01"
        size: "Standard_D4s_v4"
        admin_username: "adminuser"
        license_type: "Windows_Client"
        network_interface_keys: ["nic0"]

        os_disk:
          naming_convention:
            postfix: "01"
          caching: "ReadWrite"
          storage_account_type: "Premium_LRS"

        identity:
          type: "SystemAssigned"

        source_image_reference:
          publisher: "MicrosoftWindowsDesktop"
          offer: "windows-11"
          sku: "win11-22h2-avd"
          version: "latest"

    virtual_machine_extensions:
      AVD_DSC_Extension:
        enabled: true
        name: "AVD_DSC_Extension"
        modulesURL: "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
        host_pool:
          host_pool_key: "hostpool1"
          # hostPoolToken: "only use during testing"
          getTokenFromKeyvault: false
          # key_vault_id: "used if getTokenFromKeyvault=true"
          # keyvault_key: "used if getTokenFromKeyvault=true"
      AADLoginForWindows:
        enabled: true
        name: "AADLoginForWindows"              
```

## Example Module Reference

```yaml
module "avd_host_pools" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/avd_host_pool"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.host_pools, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

## Virtual_Machines.tf Example for AVD
module "virtual_machines" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/virtual_machine"
  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  virtual_networks    = local.networking
  keyvaults           = local.keyvaults
  availability_sets   = module.availability_sets
}

module "vm_extension_avd_dsc" {
  depends_on = [
    module.virtual_machines,
    module.avd_host_pools
  ]
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/virtual_machine_extensions?ref=feature/avd-vm-updates"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.AVD_DSC_Extension, null) != null
    && try(value.virtual_machine_extensions.AVD_DSC_Extension.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.AVD_DSC_Extension
  extension_name     = "AVD_DSC_Extension"
  avd_host_pools     = module.avd_host_pools
}

module "vm_extension_AADLoginForWindows" {
  depends_on = [
    module.vm_extension_avd_dsc
  ]
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/virtual_machine_extensions?ref=feature/avd-vm-updates"

  for_each = {
    for key, value in try(local.settings.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.AADLoginForWindows, null) != null
    && try(value.virtual_machine_extensions.AADLoginForWindows.enabled, false) == true
  }

  virtual_machine_id = module.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.AADLoginForWindows
  extension_name     = "AADLoginForWindows"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_desktop_host_pool.avdpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.registration_info](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [time_rotating.avd_registration_expiration](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the AVD Host Pool resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD host pool |
| <a name="output_name"></a> [name](#output\_name) | The Name of the AVD host pool |
| <a name="output_token"></a> [token](#output\_token) | The Registration Token of the AVD host pool |
<!-- END_TF_DOCS -->