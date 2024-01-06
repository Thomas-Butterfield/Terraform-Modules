# Express Route Circuit

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressroutecircuit}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-ERC-001
```

## Example Settings
```yaml
networking:
  express_route_circuits:
    ercircuit1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      # er_port_key: "erport1"
      # bandwidth_in_gbps: 1
      ## Can also use other values below in place of er_port_key and bandwidth_in_gbps
      service_provider_name: "Equinix"
      peering_location: "Washington DC"
      bandwidth_in_mbps: "500"
```

## Example Module Reference

```yaml
module "express_route_circuits" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/express_route_circuit"
  for_each = {
    for key, value in try(local.settings.networking.express_route_circuits, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings       = local.settings
  resource_group_name   = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  settings              = each.value
  express_route_port_id = try(module.express_route_ports[each.value.er_port_key].id, null)
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
| [azurerm_express_route_circuit.circuit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_port_id"></a> [express\_route\_port\_id](#input\_express\_route\_port\_id) | Express Route Port ID from the external ER Port module | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Express Route Circuit resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Express Route Circuit |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Express Route Circuit |
| <a name="output_service_key"></a> [service\_key](#output\_service\_key) | The Service Key of the Express Route Circuit |
| <a name="output_service_provider_provisioning_state"></a> [service\_provider\_provisioning\_state](#output\_service\_provider\_provisioning\_state) | The Service Provider Provisioning State of the Express Route Circuit |
<!-- END_TF_DOCS -->