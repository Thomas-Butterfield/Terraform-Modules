# Azure Firewall Policy

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicy}"

Example Result: AVA-EUS2-DEV-AZFW-POLICY
```

## Example Settings
```yaml
networking:  
  firewall_policies:
    fp1:
      enabled: true
      resource_group_key: "networking"
      sku: "Standard"
```

## Example Module Reference

```yaml
module "firewall_policy" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/firewall_policies"
  for_each = {
    for key, value in try(local.settings.networking.firewall_policies, {}) : key => value
    if try(value.enabled, false) == true && try(value.reused, false) == false
  }

  global_settings     = local.settings
  firewall_policy     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
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
| [azurerm_firewall_policy.fwpol](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_policy_id"></a> [base\_policy\_id](#input\_base\_policy\_id) | The ID of the base Firewall Policy | `string` | `null` | no |
| <a name="input_firewall_policy"></a> [firewall\_policy](#input\_firewall\_policy) | Configuration settings object for the Azure Firewall Policy resource | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall Policy |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Azure Firewall Policy |
<!-- END_TF_DOCS -->