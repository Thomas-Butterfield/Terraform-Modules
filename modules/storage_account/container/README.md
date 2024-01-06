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
| <a name="module_blob"></a> [blob](#module\_blob) | ../blob | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_container.stg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Storage Container resource | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the storage account in which to create the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blobs"></a> [blobs](#output\_blobs) | The Blob module object |
| <a name="output_has_immutability_policy"></a> [has\_immutability\_policy](#output\_has\_immutability\_policy) | (Bool) Immutability Policy configured on this Storage Container |
| <a name="output_has_legal_hold"></a> [has\_legal\_hold](#output\_has\_legal\_hold) | (Bool) Legal Hold configured on this Storage Container |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Container |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Storage Container |
<!-- END_TF_DOCS -->