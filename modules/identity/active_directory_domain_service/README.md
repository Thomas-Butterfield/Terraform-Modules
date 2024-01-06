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
| [azurerm_active_directory_domain_service.aadds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/active_directory_domain_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | A unique ID for the managed domain deployment |
| <a name="output_domain_controller_ip_addresses"></a> [domain\_controller\_ip\_addresses](#output\_domain\_controller\_ip\_addresses) | A list of subnet IP addresses for the domain controllers in the initial Replica Set, typically two |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The Domain Name of the Azure Active Directory Domain Service |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Active Directory Domain Service |
| <a name="output_initial_replica_set_external_access_ip_address"></a> [initial\_replica\_set\_external\_access\_ip\_address](#output\_initial\_replica\_set\_external\_access\_ip\_address) | The publicly routable IP address for the domain controllers in the initial Replica Set |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Azure Active Directory Domain Service |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The Azure resource ID for the domain service |
| <a name="output_secure_ldap"></a> [secure\_ldap](#output\_secure\_ldap) | Secure LDAP block containing the publicly routable IP address for LDAPS clients to connect to this AADDS |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The current service status for the initial Replica Set |
<!-- END_TF_DOCS -->