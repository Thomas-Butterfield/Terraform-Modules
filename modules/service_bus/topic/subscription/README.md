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
| <a name="module_correlation_filter_rules"></a> [correlation\_filter\_rules](#module\_correlation\_filter\_rules) | ./subscription_rule/correlation_filter | n/a |
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../../resource_naming | n/a |
| <a name="module_sql_filter_rules"></a> [sql\_filter\_rules](#module\_sql\_filter\_rules) | ./subscription_rule/sql_filter | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_servicebus_queues"></a> [servicebus\_queues](#input\_servicebus\_queues) | ServiceBus Queues module object for forwarded messsages property | `map` | `{}` | no |
| <a name="input_servicebus_topic_id"></a> [servicebus\_topic\_id](#input\_servicebus\_topic\_id) | ServiceBus Topic ID | `string` | n/a | yes |
| <a name="input_servicebus_topics"></a> [servicebus\_topics](#input\_servicebus\_topics) | ServiceBus Topics module object for forwarded messsages property | `map` | `{}` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the ServiceBus Subscription |
| <a name="output_name"></a> [name](#output\_name) | The Name of the ServiceBus Subscription |
| <a name="output_subscription_rules"></a> [subscription\_rules](#output\_subscription\_rules) | n/a |
<!-- END_TF_DOCS -->