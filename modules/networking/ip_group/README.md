# IP Group

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{ipgroup}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-IPGRP-001
```

## Example Settings
```yaml
networking:
  ip_groups:
    ipg1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      --TODO--
```

## Example Module Reference

```yaml
module "ip_groups" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/ip_group"
  for_each = {
    for key, value in try(local.settings.networking.ip_groups, {}) : key => value
    if try(value.enabled, false) == true
  }

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
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
| [azurerm_ip_group.ip_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ip_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the IP Group resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | VNet CIDRs Map of the IP Group to be created | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidrs"></a> [cidrs](#output\_cidrs) | The CIDRs of the IP Group |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IP Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the IP Group |
<!-- END_TF_DOCS -->