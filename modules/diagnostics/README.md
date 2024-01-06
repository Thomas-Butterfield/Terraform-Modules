# Diagnostics Setting

## Example Settings
```yaml
diagnostic_profiles:
  azfirewall:
    azfw1:
      enabled: true
      firewall_resource_id: "/subscriptions/SUBSCRIPTION_ID_VAL/resourceGroups/FIREWALL_RG_NAME/providers/Microsoft.Network/azureFirewalls/FIREWALL_NAME"
      definition_key: "azurerm_firewall"
      destination_type: "log_analytics"
      destination_key: "central_logs"

diagnostics_definition:
  azurerm_firewall:
    name: "operational_logs_and_metrics"
    log_analytics_destination_type: "AzureDiagnostics"
    categories:
      log: [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, false, 90],
        ["AzureFirewallNetworkRule", true, false, 90],
        ["AzureFirewallDnsProxy", true, false, 90],
      ]
      metric: [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]

diagnostics_destinations:
  log_analytics:
    central_logs:
      log_analytics_key: "central_logs1"

# locals
# Diagnostics services to create
  diagnostics = {
    diagnostic_profiles      = try(local.settings.diagnostic_profiles, {})
    diagnostics_definition   = try(local.settings.diagnostics_definition, {})
    diagnostics_destinations = try(local.settings.diagnostics_destinations, {})
    log_analytics            = try(module.log_analytics, {})
    storage_accounts         = try(module.storage_account, {})
  }

```

## Example Module Reference

```yaml
module "diagnostics_firewalls" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/diagnostics"
  for_each = {
    for key, value in try(local.diagnostics.diagnostic_profiles.azfirewall, {}) : key => value
    if try(value.enabled, false) == true
  }

  resource_id       = module.hub_firewall[each.value.firewall_key].id
  resource_location = local.settings.location
  diagnostics       = local.diagnostics
  profiles          = local.diagnostics.diagnostic_profiles.azfirewall
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
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Configuration settings object for the Azure Monitor Diagnostics resource | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `map` | `{}` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | Diagnostic profile map containing all the resoure profiles | `any` | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | The ID of an existing Resource on which to configure Diagnostic Settings (Fully Qualified Azure Resource ID) | `any` | n/a | yes |
| <a name="input_resource_location"></a> [resource\_location](#input\_resource\_location) | The resource location in which the referenced resource is created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Diagnostic Setting |
<!-- END_TF_DOCS -->