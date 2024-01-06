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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../../../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_subscription_rule.sql_filter](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_servicebus_subscription_id"></a> [servicebus\_subscription\_id](#input\_servicebus\_subscription\_id) | ServiceBus Subscription ID | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the ServiceBus Subscription Rule |
| <a name="output_name"></a> [name](#output\_name) | The Name of the ServiceBus Subscription Rule |
<!-- END_TF_DOCS -->