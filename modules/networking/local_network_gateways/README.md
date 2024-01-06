# Local Network Gateway

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lng}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-LNG-001
```

## Example Settings
```yaml
networking:
  local_network_gateways:
    lng1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      --TODO--
```

## Example Module Reference

```yaml
module "local_network_gateways" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/local_network_gateways"
  for_each = {
    for key, value in try(local.settings.networking.local_network_gateways, {}) : key => value
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
| [azurerm_local_network_gateway.lngw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global\_settings.location. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Local Network Gateway resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Local Network Gateway |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Local Network Gateway |
<!-- END_TF_DOCS -->