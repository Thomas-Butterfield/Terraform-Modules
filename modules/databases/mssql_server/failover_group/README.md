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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_failover_group.failover_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_failover_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_mssql_server_id"></a> [mssql\_server\_id](#input\_mssql\_server\_id) | MS SQL Server Resource ID | `string` | n/a | yes |
| <a name="input_primary_mssql_server_id"></a> [primary\_mssql\_server\_id](#input\_primary\_mssql\_server\_id) | n/a | `any` | n/a | yes |
| <a name="input_secondary_mssql_server_id"></a> [secondary\_mssql\_server\_id](#input\_secondary\_mssql\_server\_id) | n/a | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Failover Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Failover Group |
| <a name="output_partner_server"></a> [partner\_server](#output\_partner\_server) | The Partner Server block of the Failover Group |
<!-- END_TF_DOCS -->