# Automation Account

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{automationacct}"

Example Result: AVA-EUS2-DEV-AA
```

## Example Settings
```yaml
##===============================
## Single object example
##===============================
automation_accounts:
  # If multiple objects needed, override the naming mask to apply postfix
  autoacct1:
    enabled: true
    resource_group_key: "admin"
    sku_name: Basic
    # To implement Log Analytics link with the Automation Account, create a link to the LA Key as shown below
    log_analytics_links:
      lalnk1:
        log_analytics_key: "central_logs1"

##===============================
## Multiple object example
##===============================
automation_accounts:
  autoacct1:
    naming_convention:
      name_mask: "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{automationacct}{delimiter}{postfix}"
      postfix: "001"
    enabled: true
    resource_group_key: "admin"
    sku_name: Basic
    log_analytics_links:
      lalnk1:
        log_analytics_key: "central_logs1"
  autoacct2:
    naming_convention:
      name_mask: "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{automationacct}{delimiter}{postfix}"
      postfix: "002"
    enabled: true
    resource_group_key: "admin"
    sku_name: Basic
```

## Example Module Reference

```yaml
module "automation" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/automation"
  for_each = {
    for key, value in try(local.settings.automation_accounts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  automation_account  = each.value
  sku_name            = try(each.value.sku_name, null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)  
  log_analytics       = module.log_analytics
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
| [azurerm_automation_account.auto_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_log_analytics_linked_service.auto_account_la_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automation_account"></a> [automation\_account](#input\_automation\_account) | Configuration settings object for the Automation Account | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | Log Analytics module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the account - only Basic is supported at this time. Defaults to Basic | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dsc_server_endpoint"></a> [dsc\_server\_endpoint](#output\_dsc\_server\_endpoint) | The DSC Server Endpoint associated with this Automation Account |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Automation Account |
| <a name="output_la_linked_service_id"></a> [la\_linked\_service\_id](#output\_la\_linked\_service\_id) | The ID of the Log Analytics Linked Service associated with this Automation Account |
| <a name="output_la_linked_service_name"></a> [la\_linked\_service\_name](#output\_la\_linked\_service\_name) | The Name of the Log Analytics Linked Service associated with this Automation Account |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Automation Account |
<!-- END_TF_DOCS -->