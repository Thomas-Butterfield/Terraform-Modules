<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_user.account](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [azurerm_key_vault_secret.aad_user_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aad_user_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [random_password.pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_rotating.pwd](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_sleep.propagate_to_azuread](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azuread_domains.aad_domains](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_user"></a> [ad\_user](#input\_ad\_user) | Configuration settings object for the AD User resource | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_key_vaults"></a> [key\_vaults](#input\_key\_vaults) | Key Vaults module object | `map` | `{}` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Map to define the password policy to apply | `map` | <pre>{<br>  "expire_in_days": 180,<br>  "length": 250,<br>  "numeric": true,<br>  "rotation": {<br>    "months": 1<br>  },<br>  "special": false,<br>  "upper": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the user |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the user |
| <a name="output_rbac_id"></a> [rbac\_id](#output\_rbac\_id) | The object ID of the user. This attribute is used to set the role assignment |
| <a name="output_user_type"></a> [user\_type](#output\_user\_type) | The user type in the directory. Possible values are Guest or Member |
<!-- END_TF_DOCS -->