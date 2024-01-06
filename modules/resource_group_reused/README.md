# Resource Group Data Resource

## Example Settings
```yaml
resource_groups:
  networking:
    name: "NETWORK"
    enabled: true
    # reuse = true must be set to grab data resource reference
    reuse: true
```

## Example Module Reference

```yaml
module "resource_group_reused" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/resource_group_reused"
  for_each = {
    for key, value in try(local.settings.resource_groups, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }

  settings = each.value
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
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Resource Group resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Resource Group |
| <a name="output_location"></a> [location](#output\_location) | The Location of the Data Resource Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Data Resource Group |
| <a name="output_tags"></a> [tags](#output\_tags) | The Tags of the Data Resource Group |
<!-- END_TF_DOCS -->