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
| [azurerm_app_service_environment_v3.ase](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_environment_v3) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_suffix"></a> [dns\_suffix](#output\_dns\_suffix) | The DNS suffix for this App Service Environment V3 |
| <a name="output_external_inbound_ip_addresses"></a> [external\_inbound\_ip\_addresses](#output\_external\_inbound\_ip\_addresses) | The external inbound IP addresses of the App Service Environment V3 |
| <a name="output_id"></a> [id](#output\_id) | The ID of the App Service Environment V3 |
| <a name="output_inbound_network_dependencies"></a> [inbound\_network\_dependencies](#output\_inbound\_network\_dependencies) | An Inbound Network Dependencies block as defined below |
| <a name="output_internal_inbound_ip_addresses"></a> [internal\_inbound\_ip\_addresses](#output\_internal\_inbound\_ip\_addresses) | The internal inbound IP addresses of the App Service Environment V3 |
| <a name="output_ip_ssl_address_count"></a> [ip\_ssl\_address\_count](#output\_ip\_ssl\_address\_count) | The number of IP SSL addresses reserved for the App Service Environment V3 |
| <a name="output_linux_outbound_ip_addresses"></a> [linux\_outbound\_ip\_addresses](#output\_linux\_outbound\_ip\_addresses) | Outbound addresses of Linux based Apps in this App Service Environment V3 |
| <a name="output_location"></a> [location](#output\_location) | The location where the App Service Environment exists |
| <a name="output_name"></a> [name](#output\_name) | The Name of the App Service Environment V3 |
| <a name="output_pricing_tier"></a> [pricing\_tier](#output\_pricing\_tier) | Pricing tier for the front end instances |
| <a name="output_windows_outbound_ip_addresses"></a> [windows\_outbound\_ip\_addresses](#output\_windows\_outbound\_ip\_addresses) | Outbound addresses of Windows based Apps in this App Service Environment V3 |
<!-- END_TF_DOCS -->