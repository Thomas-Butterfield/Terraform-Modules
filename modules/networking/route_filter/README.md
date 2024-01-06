# Route Filter

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{routefilter}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-RF-001
```

## Example Settings
```yaml
networking:
  route_filters:
    rf1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      rule:
        name: "RF_RULE1"
        access: "Allow"
        rule_type: "Community"
        communities: ["12076:5010", "12076:5020"]
```

## Example Module Reference

```yaml
module "route_filters" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/route_filter"
  for_each = {
    for key, value in try(local.settings.networking.route_filters, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  settings            = each.value
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
| [azurerm_route_filter.rt_filter](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_filter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Route Filter resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Filter |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Route Filter |
<!-- END_TF_DOCS -->