# Route Table Data Resource

## Example Settings
```yaml
networking:
  route_tables:
    AzFirewall:
      enabled: true
      reuse: true      
      name: "RouteTable-Firewall"
      rg_name: "networking"
```

## Example Module Reference

```yaml

module "route_tables_reused" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/route_tables_reused"
  for_each = {
    for key, value in try(local.settings.networking.route_tables, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings     = local.settings
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

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Route Table resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Table |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Route Table |
| <a name="output_route"></a> [route](#output\_route) | One or more route blocks |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The collection of Subnets associated with this route table |
<!-- END_TF_DOCS -->