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
| [azuread_service_principal.sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [time_sleep.propagate_to_azuread](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The application ID (client ID) of the application for which to create a service principal | `string` | `null` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The Application Id of the Service Principal |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the application associated with this service principal |
| <a name="output_id"></a> [id](#output\_id) | The Id of the Service Principal |
| <a name="output_oauth2_permission_scopes"></a> [oauth2\_permission\_scopes](#output\_oauth2\_permission\_scopes) | A list of OAuth 2.0 delegated permission scopes exposed by the associated application |
| <a name="output_oauth2_permission_scopes_ids"></a> [oauth2\_permission\_scopes\_ids](#output\_oauth2\_permission\_scopes\_ids) | A mapping of OAuth2.0 permission scope values to scope IDs, as exposed by the associated application, intended to be useful when referencing permission scopes in other resources in your configuration |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The Object Id of the Service Principal |
| <a name="output_rbac_id"></a> [rbac\_id](#output\_rbac\_id) | The object ID of the service principal used for RBAC |
| <a name="output_redirect_uris"></a> [redirect\_uris](#output\_redirect\_uris) | A list of URLs where user tokens are sent for sign-in with the associated application, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent for the associated application |
| <a name="output_saml_metadata_url"></a> [saml\_metadata\_url](#output\_saml\_metadata\_url) | The URL where the service exposes SAML metadata for federation |
| <a name="output_service_principal_names"></a> [service\_principal\_names](#output\_service\_principal\_names) | A list of identifier URI(s), copied over from the associated application |
| <a name="output_sign_in_audience"></a> [sign\_in\_audience](#output\_sign\_in\_audience) | The Microsoft account types that are supported for the associated application |
| <a name="output_type"></a> [type](#output\_type) | Identifies whether the service principal represents an application or a managed identity |
<!-- END_TF_DOCS -->