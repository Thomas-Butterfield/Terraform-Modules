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
| <a name="module_queue_auth_rules"></a> [queue\_auth\_rules](#module\_queue\_auth\_rules) | ./queue_auth_rule | n/a |
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_queue.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue) | resource |

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
| <a name="output_id"></a> [id](#output\_id) | The ID of the ServiceBus Queue |
| <a name="output_name"></a> [name](#output\_name) | The name of the ServiceBus Queue |
| <a name="output_queue_auth_rules"></a> [queue\_auth\_rules](#output\_queue\_auth\_rules) | The queue auth rules associated with this queue |
<!-- END_TF_DOCS -->