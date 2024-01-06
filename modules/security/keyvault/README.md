# Key Vault

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{keyvault}"

Example Result: AVA-EUS2-DEV-KV
```

## Example Settings
```yaml
keyvaults:
  kv1:
    # Example name override
    # naming_convention:
    #   name_mask: "{name}"
    # name: "SPOKE1-EUS2-DEV-KV"
    enabled: true
    resource_group_key: "admin"
    enabled_for_disk_encryption: true
    sku_name: standard
```

## Example Module Reference

```yaml
module "keyvault" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/keyvault"
  for_each = {
    for key, value in try(local.settings.keyvaults, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  key_vault           = each.value
  tenant_id           = var.tenant_id
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Configuration settings object for the Key Vault resource | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Managed Identities module object | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints map settings object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault | `string` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Key Vault |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The Key Vault URL of the Key Vault |
<!-- END_TF_DOCS -->