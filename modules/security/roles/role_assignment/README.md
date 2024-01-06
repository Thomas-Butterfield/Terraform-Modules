# Role Assignment

## Example Settings
```yaml
role_assignments:
  ra1:
    scope: "keyvault"
    scope_key: "kv1"
    mode: "built-in"
    enabled: true
    role_mappings:
      "Key Vault Administrator":
        object_ids: 
          id1: "af623f5f-502a-456a-9507-3e836783zzzz"
          id2: "737cdfea-a3c7-44f8-950d-516b50a9zzzz"
          id3: "bdc76e38-406c-4bea-827b-0e5b51c0zzzz"
          id4: "2e32a95b-29ec-4852-a92c-f67bc315zzzz"
  ra2:
    scope: "resourcegroup"
    scope_key: "avd"
    mode: "built-in"
    enabled: true
    role_mappings:
      "Virtual Machine User Login":
        azuread_group_keys:
          avd_group: "avd_group"
          avd_group_reused: "avd_group_reused"
      "Desktop Virtualization User":
        azuread_group_keys:
          avd_group: "avd_group"
```

## Example Module Reference

```yaml
module "roles" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/roles/role_assignment"
  for_each = {
    for key, value in try(local.settings.role_assignments, {}) : key => value
    if try(value.enabled, false) == true
  }

  scope          = each.value.scope == "keyvault" ? module.keyvault[each.value.scope_key].id : each.value.scope == "resourcegroup" ? local.resource_groups[each.value.scope_key].id : null
  mode           = each.value.mode
  role_mappings  = try(each.value.role_mappings, {})
  azuread_groups = local.azuread_groups
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_assignment"></a> [assignment](#module\_assignment) | ./assignment | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_apps"></a> [azuread\_apps](#input\_azuread\_apps) | Azure AD Apps module object | `map` | `{}` | no |
| <a name="input_azuread_groups"></a> [azuread\_groups](#input\_azuread\_groups) | Azure AD Groups module object | `map` | `{}` | no |
| <a name="input_azuread_service_principals"></a> [azuread\_service\_principals](#input\_azuread\_service\_principals) | Azure AD Service Principals module object | `map` | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object from data.azurerm\_client\_config | `any` | `null` | no |
| <a name="input_custom_roles"></a> [custom\_roles](#input\_custom\_roles) | Custom Roles module object | `map` | `{}` | no |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | Managed Identities module object | `map` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | Interal switch (built-in or custom) to determine retrieval of custom role definition value | `string` | n/a | yes |
| <a name="input_role_mappings"></a> [role\_mappings](#input\_role\_mappings) | Configuration settings map containing the role assignments | `any` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_assignments"></a> [role\_assignments](#output\_role\_assignments) | The Role Assignments module object |
<!-- END_TF_DOCS -->