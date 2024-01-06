# Azure Virtual Desktop Application Group

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"

Example Result: AVA-EUS2-DEV-AVD-APPGROUP
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
  workspaces:
    workspace1:
      enabled: true
      resource_group_key: "avd"
      name: "WORKSPACE"
  application_groups:
    appgroup1:
      enabled: true
      resource_group_key: "avd"
      host_pool_key: "hostpool1"
      workspace_key: "workspace1"
      type: "Desktop"
      name: "APPGROUP"
```

## Example Module Reference

```yaml
module "avd_app_groups" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/avd_application_group"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.application_groups, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  host_pool_id        = module.avd_host_pools[each.value.host_pool_key].id
  workspace_id        = module.avd_workspaces[each.value.workspace_key].id
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_desktop_application_group.dag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.dag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace_application_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_host_pool_id"></a> [host\_pool\_id](#input\_host\_pool\_id) | Resource ID for an AVD Host Pool to associate with the AVD Application Group | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the AVD Application Group resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The resource ID for the AVD Workspace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Application Group |
<!-- END_TF_DOCS -->