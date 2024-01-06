# Log Analytics Workspace Data Resource

## Example Settings
```yaml
loganalytics:
  central_logs1:
    enabled: true
    reuse: true
    name: "SHAREDSVC-EUS2-DEV-LA"
    rg_name: "SHAREDSVC-EUS2-DEV-MONITORING-RG"
```

## Example Module Reference

```yaml
module "log_analytics_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/log_analytics_reused"
  providers = {
    azurerm                    = azurerm
    azurerm.sharedsvc_provider = azurerm.sharedsvc_subscription
  }

  for_each = {
    for key, value in try(local.settings.loganalytics, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }

  name                = each.value.name
  resource_group_name = each.value.rg_name
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.sharedsvc_provider"></a> [azurerm.sharedsvc\_provider](#provider\_azurerm.sharedsvc\_provider) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Log Analytics Workspace resource | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Log Analytics Workspace |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Log Analytics Workspace |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The Primary Shared Key of the Log Analytics Workspace |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group Name of the Log Analytics Workspace |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Workspace ID of the Log Analytics Workspace |
<!-- END_TF_DOCS -->