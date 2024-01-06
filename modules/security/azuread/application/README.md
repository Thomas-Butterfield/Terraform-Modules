<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [time_sleep.propagate_to_azuread](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_api_permissions"></a> [azuread\_api\_permissions](#input\_azuread\_api\_permissions) | n/a | `map` | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object from data.azurerm\_client\_config | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | A mapping of app role values to app role IDs, intended to be useful when referencing app roles in other resources in your configuration |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The Application Id of the Application |
| <a name="output_azuread_application"></a> [azuread\_application](#output\_azuread\_application) | Application object output |
| <a name="output_azuread_service_principal"></a> [azuread\_service\_principal](#output\_azuread\_service\_principal) | This attribute is used to set the role assignment for an application |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The Client Id of the Application |
| <a name="output_disabled_by_microsoft"></a> [disabled\_by\_microsoft](#output\_disabled\_by\_microsoft) | Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | CDN URL to the application's logo, as uploaded with the logo\_image property |
| <a name="output_oauth2_permission_scope_ids"></a> [oauth2\_permission\_scope\_ids](#output\_oauth2\_permission\_scope\_ids) | A mapping of OAuth2.0 permission scope values to scope IDs, intended to be useful when referencing permission scopes in other resources in your configuration |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The Object Id of the Application |
| <a name="output_publisher_domain"></a> [publisher\_domain](#output\_publisher\_domain) | The verified publisher domain for the application |
| <a name="output_rbac_id"></a> [rbac\_id](#output\_rbac\_id) | This attribute is used to set the role assignment for an application |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenand\_id of the Azure AD Group |
<!-- END_TF_DOCS -->