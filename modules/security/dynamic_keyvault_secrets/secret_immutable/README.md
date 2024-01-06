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
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | Key Vault resource ID used if ommitting var.keyvault\_key and var.keyvaults | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Key Vault Secret Name | `string` | n/a | yes |
| <a name="input_value"></a> [value](#input\_value) | Key Vault Secret Value | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->