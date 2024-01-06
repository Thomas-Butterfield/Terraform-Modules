<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group_member.ids](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.msi_ids](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.mssql_server_ids](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_service_principals"></a> [azuread\_service\_principals](#input\_azuread\_service\_principals) | n/a | `map` | `{}` | no |
| <a name="input_group_object_id"></a> [group\_object\_id](#input\_group\_object\_id) | n/a | `any` | n/a | yes |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | n/a | `map` | `{}` | no |
| <a name="input_member_object_id"></a> [member\_object\_id](#input\_member\_object\_id) | n/a | `any` | `null` | no |
| <a name="input_members"></a> [members](#input\_members) | n/a | `map` | `{}` | no |
| <a name="input_mssql_servers"></a> [mssql\_servers](#input\_mssql\_servers) | n/a | `map` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->