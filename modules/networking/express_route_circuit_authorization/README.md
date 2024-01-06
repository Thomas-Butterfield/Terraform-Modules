# Express Route Circuit Authorization

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuitauth}{delimiter}{postfix}"

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
| [azurerm_express_route_circuit_authorization.er_circuit_auth](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_authorization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_circuit_name"></a> [express\_route\_circuit\_name](#input\_express\_route\_circuit\_name) | The name of the Express Route Circuit in which to create the Authorization | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authorization_key"></a> [authorization\_key](#output\_authorization\_key) | The Authorization Key |
| <a name="output_authorization_use_status"></a> [authorization\_use\_status](#output\_authorization\_use\_status) | The authorization use status |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Express Route Connection |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Express Route Connection |
<!-- END_TF_DOCS -->