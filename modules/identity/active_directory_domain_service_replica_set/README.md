<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_active_directory_domain_service_replica_set.aaddsrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/active_directory_domain_service_replica_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_service_id"></a> [domain\_service\_id](#input\_domain\_service\_id) | The ID of the Domain Service for which to create this Replica Set | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_controller_ip_addresses"></a> [domain\_controller\_ip\_addresses](#output\_domain\_controller\_ip\_addresses) | A list of subnet IP addresses for the domain controllers in this Replica Set, typically two |
| <a name="output_external_access_ip_address"></a> [external\_access\_ip\_address](#output\_external\_access\_ip\_address) | The publicly routable IP address for the domain controllers in this Replica Set |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Domain Service Replica Set |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The current service status for the replica set |
<!-- END_TF_DOCS -->