<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_diagnostic_event_hub_namespaces"></a> [diagnostic\_event\_hub\_namespaces](#module\_diagnostic\_event\_hub\_namespaces) | ../private_endpoint | n/a |
| <a name="module_diagnostic_storage_account"></a> [diagnostic\_storage\_account](#module\_diagnostic\_storage\_account) | ../private_endpoint | n/a |
| <a name="module_event_hub_namespaces"></a> [event\_hub\_namespaces](#module\_event\_hub\_namespaces) | ../private_endpoint | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../private_endpoint | n/a |
| <a name="module_mssql_servers"></a> [mssql\_servers](#module\_mssql\_servers) | ../private_endpoint | n/a |
| <a name="module_mysql_servers"></a> [mysql\_servers](#module\_mysql\_servers) | ../private_endpoint | n/a |
| <a name="module_recovery_vault"></a> [recovery\_vault](#module\_recovery\_vault) | ../private_endpoint | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ../private_endpoint | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Private DNS settings map object | `any` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints configuration settings map | `any` | n/a | yes |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | Resource ID map of remote objects | `any` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Resource Groups module object | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | The ID of the VNet | `string` | n/a | yes |
| <a name="input_vnet_location"></a> [vnet\_location](#input\_vnet\_location) | The Location of the VNet | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | The Resource Group Name of the VNet | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->