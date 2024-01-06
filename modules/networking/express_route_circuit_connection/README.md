# Express Route Connection

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuitconn}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-ERP-001
```

## Example Settings
--TODO--

## Example Module Reference
--TODO--

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
| [azurerm_express_route_circuit_connection.er_circuit_conn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_peer_peering_id"></a> [peer\_peering\_id](#input\_peer\_peering\_id) | The ID of the peered Express Route Circuit Private Peering | `string` | n/a | yes |
| <a name="input_peering_id"></a> [peering\_id](#input\_peering\_id) | The ID of the Express Route Circuit Private Peering that this Express Route Circuit Connection connects with | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Express Route Connection resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Express Route Connection |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Express Route Connection |
<!-- END_TF_DOCS -->