# Network Security Group Flow Logs

## Default Naming Convention
```
name_mask = "{name}{delimiter}{nsgflowlogs}"

Example Result: AVA-DEMO-CUS-SHAREDSVC-PROD-MGMT-SNET_10.155.20.32_27-NSG-NSGFlowLog
```

## Example Settings
```yaml
networking:
  network_security_group_definition:
    # This entry is applied to all subnets with no NSG defined
    empty_nsg:
      name: "empty_nsg"
      resource_group_key: "networking"
      flow_logs:
        fl1:
          enabled: true
          storage_account:
            storage_account_key: "st1"
            retention:
              enabled: true
              days: 30

storageaccounts:
  st1:
    enabled: true
    name: "avademocusshrdsvcsa01"
    resource_group_key: "admin"
    account_tier: Standard
    access_tier: Hot
    account_replication_type: LRS
    account_kind: StorageV2

```

## Example Module Reference

```yaml
module "networking" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings                   = local.settings
  network_security_group_definition = try(local.settings.networking.network_security_group_definition, {})
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  virtual_network                   = each.value
  route_tables                      = module.route_tables
  tags                              = try(each.value.tags, null)
  diagnostics                       = local.diagnostics
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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_watcher_flow_log.flow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostics object for the NSG Flow Logs resource | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_network_watchers"></a> [network\_watchers](#input\_network\_watchers) | Network Watcher module object | `map` | `{}` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | NSG Name that will be used as a default name for the NSG Flow Log | `string` | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | Fully qualified Azure resource identifier for which you enable diagnostics | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the NSG Flow Logs resource | `map` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->