# Recovery Service Vault

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{rsv}"

Example Result: AVA-EUS2-DEV-RSV
```

## Example Settings
```yaml
recovery_vaults:
  rsv1:
    enabled: true
    resource_group_key: "backup"
    enable_identity: true
```

## Example Module Reference

```yaml
module "recovery_vault" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/recovery_vault"
  for_each = {
    for key, value in try(local.settings.recovery_vaults, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  recovery_vault      = each.value
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
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_file_share.fs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |
| [azurerm_backup_policy_vm.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_recovery_services_vault.asr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_site_recovery_fabric.recovery_fabric](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_protection_container.protection_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container_mapping.container-mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping) | resource |
| [azurerm_site_recovery_replication_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy) | resource |
| [time_sleep.delay_create](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Private DNS module object | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints module object | `map` | `{}` | no |
| <a name="input_recovery_vault"></a> [recovery\_vault](#input\_recovery\_vault) | Configuration settings object for the Recovery Vault resource | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The sku which in theory should default between GRS and LRS, but Microsoft does not seem to have this well documented. Possible values are Standard, RS0. Defaults to Standard | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_policies"></a> [backup\_policies](#output\_backup\_policies) | The Backup Policies map object of the Recovery Vault |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Recovery Vault |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Recovery Vault |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Identity Principal ID of the Recovery Vault |
| <a name="output_replication_policies"></a> [replication\_policies](#output\_replication\_policies) | The Replication Policy resource object of the Recovery Vault |
| <a name="output_soft_delete_enabled"></a> [soft\_delete\_enabled](#output\_soft\_delete\_enabled) | (Bool) Soft Delete Enabled Flag of the Recovery Vault |
<!-- END_TF_DOCS -->