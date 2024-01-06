# Storage Account

## Example Settings
```yaml
storageaccounts:
  st1:
    enabled: true
    # Name is passed as-is and forced lowercase
    name: "avaspkedeveus2x"
    resource_group_key: "admin"
    account_tier: Standard
    access_tier: Hot
    account_replication_type: LRS
    account_kind: StorageV2
```

## Example Module Reference

```yaml
module "storage_account" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/storage_account"
  for_each = {
    for key, value in try(local.settings.storageaccounts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  storage_account     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  virtual_networks    = module.networking
  private_endpoints   = try(local.settings.networking.private_endpoints, {})
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
| <a name="module_container"></a> [container](#module\_container) | ./container | n/a |
| <a name="module_data_lake_filesystem"></a> [data\_lake\_filesystem](#module\_data\_lake\_filesystem) | ./data_lake_filesystem | n/a |
| <a name="module_file_share"></a> [file\_share](#module\_file\_share) | ./file_share | n/a |
| <a name="module_management_policy"></a> [management\_policy](#module\_management\_policy) | ./management_policy | n/a |
| <a name="module_queue"></a> [queue](#module\_queue) | ./queue | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_container_storage_account.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_container_storage_account) | resource |
| [azurerm_storage_account.stg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Private DNS module object | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints map settings object | `map` | `{}` | no |
| <a name="input_recovery_vaults"></a> [recovery\_vaults](#input\_recovery\_vaults) | Recovery Vault module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | Configuration settings object for the Storage Account resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_container_id"></a> [backup\_container\_id](#output\_backup\_container\_id) | The ID of the Backup Storage Account Container |
| <a name="output_containers"></a> [containers](#output\_containers) | The Containers module object |
| <a name="output_data_lake_filesystems"></a> [data\_lake\_filesystems](#output\_data\_lake\_filesystems) | The data Lake Filesystem module object |
| <a name="output_file_share"></a> [file\_share](#output\_file\_share) | The File Shares module object |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account |
| <a name="output_identity"></a> [identity](#output\_identity) | The Identity object for the Storage Account |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Storage Account |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Access Key for the Storage Account |
| <a name="output_primary_blob_connection_string"></a> [primary\_blob\_connection\_string](#output\_primary\_blob\_connection\_string) | The Primary Blob Connection String for the Storage Account |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The Primary Blob Endpoint URL for the Storage Account |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The Primary Connection String for the Storage Account |
| <a name="output_primary_web_host"></a> [primary\_web\_host](#output\_primary\_web\_host) | The Primary Web Hostname for the Storage Account |
| <a name="output_queues"></a> [queues](#output\_queues) | The Queues module object |
| <a name="output_rbac_id"></a> [rbac\_id](#output\_rbac\_id) | The Principal ID for the Service Principal associated with the Identity of this Storage Account. (Extracted from the identity block) |
<!-- END_TF_DOCS -->