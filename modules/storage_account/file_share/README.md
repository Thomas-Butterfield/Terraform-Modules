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
| <a name="module_file_share_directory"></a> [file\_share\_directory](#module\_file\_share\_directory) | ../file_share_directory | n/a |
| <a name="module_file_share_file"></a> [file\_share\_file](#module\_file\_share\_file) | ../file_share_file | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_file_share.fs_backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_file_share) | resource |
| [azurerm_storage_share.fs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_recovery_vault"></a> [recovery\_vault](#input\_recovery\_vault) | Recovery Vault module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Storage File Share resource | `any` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Specifies the ID of the Storage Account in which the File Share should exist | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the storage account in which to create the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_share_directories"></a> [file\_share\_directories](#output\_file\_share\_directories) | The File Share Directories of this Storage File Share |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage File Share |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Storage File Share |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | The Resource Manager ID of this Storage File Share |
| <a name="output_url"></a> [url](#output\_url) | The URL of the Storage File Share |
<!-- END_TF_DOCS -->