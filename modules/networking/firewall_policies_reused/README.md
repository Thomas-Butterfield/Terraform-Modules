# Azure Firewall Policy Data Resource

## Example Settings
```yaml
networking:  
  firewall_policies:
    fp1:
      enabled: true      
      rg_name: NETWORKING-RG
      name: FWPOLICY1
      reused: true

```

## Example Module Reference

```yaml
module "firewall_policy_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/firewall_policies_reused"
  for_each = {
    for key, value in try(local.settings.networking.firewall_policies, {}) : key => value
    if try(value.enabled, false) == true && try(value.reused, false) == true
  }

  global_settings     = local.settings
  firewall_policy     = each.value
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
| [azurerm_firewall_policy.fwpol](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/firewall_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_policy"></a> [firewall\_policy](#input\_firewall\_policy) | Configuration settings object for the Azure Firewall Policy resource | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall Policy Data Resource |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Azure Firewall Policy Data Resource |
<!-- END_TF_DOCS -->