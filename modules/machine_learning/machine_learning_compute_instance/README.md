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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_machine_learning_compute_instance.mlci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object from data.azurerm\_client\_config | `any` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_machine_learning_workspace_id"></a> [machine\_learning\_workspace\_id](#input\_machine\_learning\_workspace\_id) | Machine Learning Workspace ID | `string` | n/a | yes |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | Managed Identity module object | `map` | `{}` | no |
| <a name="input_ml_compute_instance"></a> [ml\_compute\_instance](#input\_ml\_compute\_instance) | Configuration settings object for the Machine Learning Compute Instance | `any` | n/a | yes |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | SSH Keys module object | `map` | `{}` | no |
| <a name="input_subnet_resource_id"></a> [subnet\_resource\_id](#input\_subnet\_resource\_id) | Virtual network subnet resource ID the compute nodes belong to | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant ID | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Machine Learning Compute Instance |
| <a name="output_identity"></a> [identity](#output\_identity) | An `identity` block as defined below, which contains the Managed Service Identity information for this Machine Learning Compute Instance |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Machine Learning Compute Instance |
| <a name="output_ssh"></a> [ssh](#output\_ssh) | An `ssh` block as defined below, which specifies policy and settings for SSH access for this Machine Learning Compute Instance |
<!-- END_TF_DOCS -->