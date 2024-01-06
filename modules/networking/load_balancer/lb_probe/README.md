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
| [azurerm_lb_probe.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_lb_probe_protocol"></a> [lb\_probe\_protocol](#input\_lb\_probe\_protocol) | Specifies the protocol of the end point. Possible values are `Http`, `Https` or `Tcp`.  | `string` | n/a | yes |
| <a name="input_lb_probe_uri"></a> [lb\_probe\_uri](#input\_lb\_probe\_uri) | The URI used for requesting health status from the backend endpoint when `lb_probe_protocol` is set to either `Http` or `Https`. | `string` | '/' | no |
| <a name="input_lb_probe_interval"></a> [lb\_probe\_interval](#input\_lb\_probe\_interval) | The interval, in seconds between probes to the backend endpoint for health status. | `number` | 15 | no |
| <a name="input_lb_failed_probes"></a> [lb\_failed\_probes](#input\_lb\_failed\_probes) | The number of failed probe attempts after which the backend endpoint is removed from rotation. | `number` | 2 | no |
| <a name="input_loadbalancer_id"></a> [loadbalancer\_id](#input\_loadbalancer\_id) | The ID of the Load Balancer in which to create the probe | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for this resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of this resource |
<!-- END_TF_DOCS -->