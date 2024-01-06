<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_service_principal_password.pwd](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azurerm_key_vault_secret.client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [time_rotating.pwd](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_sleep.propagate_to_azuread](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object from data.azurerm\_client\_config | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | Keyvaults module object | `map` | `{}` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Default password policy applies when not set in settings | `map` | <pre>{<br>  "expire_in_days": 180,<br>  "rotation": {<br>    "years": 2<br>  }<br>}</pre> | no |
| <a name="input_service_principal_application_id"></a> [service\_principal\_application\_id](#input\_service\_principal\_application\_id) | (Required) The App ID of the Application for which to create a Service Principal | `any` | n/a | yes |
| <a name="input_service_principal_id"></a> [service\_principal\_id](#input\_service\_principal\_id) | (Required) The ID of the Service Principal for which this password should be created | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_end_date"></a> [end\_date](#output\_end\_date) | The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z) |
| <a name="output_end_date_relative"></a> [end\_date\_relative](#output\_end\_date\_relative) | A relative duration for which the password is valid until, for example 240h (10 days) or 2400h30m |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | A UUID used to uniquely identify this password credential |
| <a name="output_keyvaults"></a> [keyvaults](#output\_keyvaults) | Keyvaults storing the passwords. Store the secret\_prefix-client-id, secret\_prefix-client-secret |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | The service principal ID |
| <a name="output_start_date"></a> [start\_date](#output\_start\_date) | The start date from which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z) |
| <a name="output_value"></a> [value](#output\_value) | The password for this service principal, which is generated by Azure Active Directory |
<!-- END_TF_DOCS -->