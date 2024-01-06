# Virtual WAN Data Resource - See Virtual HUB Data Resource for Implementation

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.vhub_provider"></a> [azurerm.vhub\_provider](#provider\_azurerm.vhub\_provider) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hubs"></a> [hubs](#module\_hubs) | ../virtual_wan/virtual_hub | n/a |
| <a name="module_hubs_reused"></a> [hubs\_reused](#module\_hubs\_reused) | ./virtual_hub | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_wan.vwan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_wan) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP Addresses module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |
| <a name="input_virtual_wan"></a> [virtual\_wan](#input\_virtual\_wan) | Configuration settings object for the Virtual WAN resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Virtual WAN |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Data Virtual WAN |
| <a name="output_virtual_hubs"></a> [virtual\_hubs](#output\_virtual\_hubs) | The Virtual Hubs module object |
| <a name="output_virtual_wan"></a> [virtual\_wan](#output\_virtual\_wan) | The Data Virtual WAN resource object |
<!-- END_TF_DOCS -->