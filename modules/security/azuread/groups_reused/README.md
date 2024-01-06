# Azure AD Groups Data Resource

## Example Settings
```yaml
azuread:
  groups:
    avd_group:
      enabled: true
      name: "AVD_Users_Dev"
      description: "Test AVD AD Group"
      security_enabled: true
```

## Example Module Reference

```yaml

data "azurerm_client_config" "current" {}

module "azuread_groups_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/security/azuread/groups_reused"
  for_each = {
    for key, value in try(local.settings.azuread.groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  azuread_group = each.value
  tenant_id     = var.tenant_id
  client_config = data.azurerm_client_config.current
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_group"></a> [azuread\_group](#input\_azuread\_group) | Azure AD Group settings object | `any` | n/a | yes |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object from data.azurerm\_client\_config | `any` | `null` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID where the AD Groups will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The name of the Data Azure AD Group |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The Object ID of the Data Azure AD Group |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenand\_id of the Data Azure AD Group |
<!-- END_TF_DOCS -->