# Azure Virtual Desktop Workspace

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{avd}{delimiter}{name}"

Example Result: AVA-EUS2-DEV-AVD-WORKSPACE
```

## Example Settings
```yaml
azure_virtual_desktops:
  workspaces:
    workspace1:
      enabled: true
      resource_group_key: "avd"
      name: "WORKSPACE"
```

## Example Module Reference

```yaml
module "avd_workspaces" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/avd_workspace?ref=feature/avd-module-updates"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.workspaces, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
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
| [azurerm_virtual_desktop_scaling_plan.avd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_scaling_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_avd_host_pools"></a> [avd\_host\_pools](#input\_avd\_host\_pools) | AVD Host Pools module object | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the AVD resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Scaling Plan |
| <a name="output_name"></a> [name](#output\_name) | The Name of the AVD Scaling Plan |
<!-- END_TF_DOCS -->