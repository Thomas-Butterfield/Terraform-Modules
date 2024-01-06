# Key Vault Data Resource

## Example Settings
```yaml
keyvaults:
  kv1:
    enabled: true
    reuse: true
    name: "SHAREDSVC-EUS2-DEV-KV"
    rg_name: "SHAREDSVC-EUS2-DEV-ADMIN-RG"
```

## Example Module Reference

```yaml
module "keyvault_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/keyvault_reused"
  for_each = {
    for key, value in try(local.settings.keyvaults, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  key_vault           = each.value
  tenant_id           = var.tenant_id  
}
```

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
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Configuration settings object for the Key Vault resource | `any` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Key Vault |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The Key Vault URL of the Key Vault |
<!-- END_TF_DOCS -->