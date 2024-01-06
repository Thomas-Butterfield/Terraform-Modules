# Palo Alto NVA Azure Bootstrap

## Default Naming Convention

n/a

## Example Settings
```yaml

## A storage account with a file share needs to be created in order to load the bootstrap files
storageaccounts:
  st1:
    enabled: true
    name: "seans0sta0ncus2paboot"
    resource_group_key: "networking"
    account_tier: Standard
    access_tier: Hot
    account_replication_type: LRS
    account_kind: StorageV2
    file_shares:
      fs01:
        name: "pa-bootstrap"
        quota: 1
        directories:
          dir01:
            name: "pa-bootstrap"

pa_bootstrap:
  pa_b1:
    enabled: true
    storage_account_key: "st1"
    file_share_key: "fs01"
    directory_key: "dir01"
```

## Example Module Reference

```yaml
module "pa_bootstrap_fileshare" {
  source               = ""[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/paloalto/azure_bootstrap/"

  for_each = {
    for key, value in try(local.settings.pa_bootstrap, {}) : key => value
    if try(value.enabled, false) == true
  }

  storage_account_name = module.storage_account[each.value.storage_account_key].name
  storage_account_key  = module.storage_account[each.value.storage_account_key].primary_access_key
  storage_share_name   = module.storage_account[each.value.storage_account_key].file_share[each.value.file_share_key].name
  storage_dir_name     = module.storage_account[each.value.storage_account_key].file_share[each.value.file_share_key].file_share_directories[each.value.directory_key].name
  local_file_path      = "./paloalto/bootstrap_files/common_fw/"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.upload](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_file_path"></a> [local\_file\_path](#input\_local\_file\_path) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_key"></a> [storage\_account\_key](#input\_storage\_account\_key) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_dir_name"></a> [storage\_dir\_name](#input\_storage\_dir\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_share_name"></a> [storage\_share\_name](#input\_storage\_share\_name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->