# Network Watcher

## Default Naming Convention
```
name_mask = "{networkwatcher}_${local.name_mask_location}"

Example Result: NetworkWatcher_EUS2
```

## Example Settings
```yaml
networking:
  network_watchers:
    nw1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      --TODO--
```

## Example Module Reference

```yaml
module "network_watchers" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/network_watcher"
  for_each = {
    for key, value in try(local.settings.networking.network_watchers, {}) : key => value
    if try(value.enabled, false) == true
  }

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) != null ? each.value.region : null #override location if needed
  settings            = each.value
  global_settings     = local.settings
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
| [azurerm_network_watcher.netwatcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global\_settings.location. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Network Watcher resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Network Watcher |
| <a name="output_location"></a> [location](#output\_location) | The Location of the Network Watcher |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Network Watcher |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The RG Name of the Network Watcher |
<!-- END_TF_DOCS -->