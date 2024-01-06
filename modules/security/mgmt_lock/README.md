# Management Lock

## Example Settings
```yaml
mgmt_lock:
  lock1:
    enabled: true
    naming_convention:
      postfix: "01" 
    # Either set a resource_key: or scope_id:
    # scope_id: "some/literal/path/resource_id"
    resource_key: vm1
    lock_level: "ReadOnly" # ReadOnly or CanNotDelete
    notes: "Lock reason can go here."
```

## Example Module Reference

```yaml
module "mgmt_lock" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/mgmt_lock"

  for_each = {
    for key, value in try(local.settings.mgmt_lock, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings       = local.settings
  settings              = each.value

  # First we check if a literal scope_id is set. If not, then we use the resource_key to grab the resource id
  # Either scope_id or resource_key must be set in settings.yaml
  scope_id              = try(each.value.scope_id, module.virtual_machines[each.value.resource_key].id)
  ## Here's another example referring to a Resource Group as the scope
  # scope_id              = try(each.value.scope_id, module.resource_groups[each.value.resource_key].id)
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
| [azurerm_management_lock.lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_scope_id"></a> [scope\_id](#input\_scope\_id) | Specifies the scope at which the Management Lock should be created | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Management Lock resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Management Lock |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Management Lock |
<!-- END_TF_DOCS -->