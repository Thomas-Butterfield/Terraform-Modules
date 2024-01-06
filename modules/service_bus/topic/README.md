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
| <a name="module_topic_auth_rules"></a> [topic\_auth\_rules](#module\_topic\_auth\_rules) | ./topic_auth_rule | n/a |
| <a name="module_topic_subscriptions"></a> [topic\_subscriptions](#module\_topic\_subscriptions) | ./subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_topic.topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_servicebus_namespace_id"></a> [servicebus\_namespace\_id](#input\_servicebus\_namespace\_id) | ServiceBus Namespace ID | `string` | n/a | yes |
| <a name="input_servicebus_queues"></a> [servicebus\_queues](#input\_servicebus\_queues) | ServiceBus Queues module object for forwarded messsages property | `map` | `{}` | no |
| <a name="input_servicebus_topics"></a> [servicebus\_topics](#input\_servicebus\_topics) | ServiceBus Topics module object for forwarded messsages property | `map` | `{}` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the ServiceBus Topic |
| <a name="output_name"></a> [name](#output\_name) | The name of the ServiceBus Topic |
| <a name="output_topic_auth_rules"></a> [topic\_auth\_rules](#output\_topic\_auth\_rules) | The Topic Authorization Rules associated with this Topic |
| <a name="output_topic_subscriptions"></a> [topic\_subscriptions](#output\_topic\_subscriptions) | The Topic Subscriptions associated with this Topic |
<!-- END_TF_DOCS -->