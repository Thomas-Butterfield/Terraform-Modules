<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | ./secret | n/a |
| <a name="module_secret_immutable"></a> [secret\_immutable](#module\_secret\_immutable) | ./secret_immutable | n/a |
| <a name="module_secret_value"></a> [secret\_value](#module\_secret\_value) | ./secret | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | Key Vault resource ID | `string` | n/a | yes |
| <a name="input_objects"></a> [objects](#input\_objects) | Key Vault Secret values map object | `map` | `{}` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Key Vault Secret Key resource | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->