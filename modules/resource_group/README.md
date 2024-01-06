# Resource Group

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{rgName}{delimiter}{rgSuffix}"

Example Result: AVA-EUS2-DEV-NETWORK-RG
```

## Example Settings
```yaml
resource_groups:
  networking:
    name: "NETWORK"
    enabled: true
  backup:
    name: "BACKUP"
    enabled: true
    tags:
      TestCustomTag: CustomTag1
  db:
    name: "DB"
    enabled: false
  networkwatcher:
    naming_convention:
      name_mask: "{name}"
    name: "NetworkWatcherRG"
    enabled: true
```

## Example Module Reference

```yaml
module "resource_groups" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/resource_group"
  for_each = {
    for key, value in try(local.settings.resource_groups, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  resource_group_name = each.value.name
  resource_group      = each.value
  global_settings     = local.settings
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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Configuration settings object for the Resource Group resource | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group |
| <a name="output_location"></a> [location](#output\_location) | The Location of the Resource Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Resource Group |
| <a name="output_tags"></a> [tags](#output\_tags) | The Tags of the Resource Group |
<!-- END_TF_DOCS -->