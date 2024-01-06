<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azuread_apps"></a> [azuread\_apps](#module\_azuread\_apps) | ./member | n/a |
| <a name="module_azuread_service_principals"></a> [azuread\_service\_principals](#module\_azuread\_service\_principals) | ./member | n/a |
| <a name="module_azuread_service_principals_membership"></a> [azuread\_service\_principals\_membership](#module\_azuread\_service\_principals\_membership) | ./membership | n/a |
| <a name="module_group_keys"></a> [group\_keys](#module\_group\_keys) | ./member | n/a |
| <a name="module_group_name"></a> [group\_name](#module\_group\_name) | ./member | n/a |
| <a name="module_managed_identities"></a> [managed\_identities](#module\_managed\_identities) | ./member | n/a |
| <a name="module_managed_identities_membership"></a> [managed\_identities\_membership](#module\_managed\_identities\_membership) | ./membership | n/a |
| <a name="module_membership_logged_in_object_id"></a> [membership\_logged\_in\_object\_id](#module\_membership\_logged\_in\_object\_id) | ./member | n/a |
| <a name="module_membership_object_id"></a> [membership\_object\_id](#module\_membership\_object\_id) | ./member | n/a |
| <a name="module_mssql_servers_membership"></a> [mssql\_servers\_membership](#module\_mssql\_servers\_membership) | ./membership | n/a |
| <a name="module_object_id"></a> [object\_id](#module\_object\_id) | ./member | n/a |
| <a name="module_user_principal_names"></a> [user\_principal\_names](#module\_user\_principal\_names) | ./member | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_group.name](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_apps"></a> [azuread\_apps](#input\_azuread\_apps) | n/a | `map` | `{}` | no |
| <a name="input_azuread_groups"></a> [azuread\_groups](#input\_azuread\_groups) | n/a | `map` | `{}` | no |
| <a name="input_azuread_service_principals"></a> [azuread\_service\_principals](#input\_azuread\_service\_principals) | n/a | `map` | `{}` | no |
| <a name="input_azuread_users"></a> [azuread\_users](#input\_azuread\_users) | n/a | `map` | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | n/a | `any` | n/a | yes |
| <a name="input_group_id"></a> [group\_id](#input\_group\_id) | n/a | `any` | `null` | no |
| <a name="input_group_key"></a> [group\_key](#input\_group\_key) | n/a | `any` | `null` | no |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | n/a | `map` | `{}` | no |
| <a name="input_mssql_servers"></a> [mssql\_servers](#input\_mssql\_servers) | n/a | `map` | `{}` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->