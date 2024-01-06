# Log Analytics Workspace

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{loganalytics}"

Example Result: AVA-EUS2-DEV-LA
```

## Example Settings
```yaml
loganalytics:
  # If multiple, override the naming mask to apply postfix
  central_logs1:
    enabled: true
    resource_group_key: "monitoring"
    sku:  PerGB2018
    retention: 90
    # Solution Packs Information
    solutions:    
      solution1: 
        enabled: true
        product: OMSGallery/ADReplication
        name: ADReplication
        publisher: Microsoft
      solution2: 
        enabled: true
        product: OMSGallery/AntiMalware
        name: AntiMalware
        publisher: Microsoft
      solution3: 
        enabled: true
        product: OMSGallery/AgentHealthAssessment
        name: AgentHealthAssessment
        publisher: Microsoft
      solution4: 
        enabled: true
        product: OMSGallery/Updates
        name: Updates
        publisher: Microsoft
      solution5: 
        enabled: true
        product: OMSGallery/NetworkMonitoring
        name: NetworkMonitoring
        publisher: Microsoft
      solution6: 
        enabled: true
        product: OMSGallery/KeyVaultAnalytics
        name: KeyVaultAnalytics
        publisher: Microsoft
      solution7: 
        enabled: true
        product: OMSGallery/ServiceDesk
        name: ServiceDesk
        publisher: Microsoft
      solution8: 
        enabled: true
        product: OMSGallery/AzureActivity
        name: AzureActivity
        publisher: Microsoft
      solution9: 
        enabled: true
        product: OMSGallery/AzureAutomation
        name: AzureAutomation
        publisher: Microsoft
      solution10: 
        enabled: false
        product: OMSGallery/AzureBackup
        name: AzureBackup
        publisher: Microsoft
      solution11: 
        enabled: true
        product: OMSGallery/AzureSQLAnalytics
        name: AzureSQLAnalytics
        publisher: Microsoft
      solution12: 
        enabled: true
        product: OMSGallery/ChangeTracking
        name: ChangeTracking
        publisher: Microsoft
      solution13: 
        enabled: true
        product: OMSGallery/Security
        name: Security
        publisher: Microsoft

```

## Example Module Reference

```yaml
module "log_analytics" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/log_analytics"
  for_each = {
    for key, value in try(local.settings.loganalytics, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  log_analytics       = each.value
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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_solution.solution](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | Configuration settings object for the Log Analytics Workspace resource | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Log Analytics Workspace |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Log Analytics Workspace |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The Primary Shared Key of the Log Analytics Workspace |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group Name of the Log Analytics Workspace |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Workspace ID of the Log Analytics Workspace |
<!-- END_TF_DOCS -->