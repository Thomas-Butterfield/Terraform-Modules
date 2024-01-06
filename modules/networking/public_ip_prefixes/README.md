# Public IP Prefix

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{name}{delimiter}{publicip_prefix}"

Example Result: AVA-EUS2-DEV-Bastion-PRFX
```

## Example Settings
```yaml
public_ip_prefixes:
    pippref1:
      enabled: true
      resource_group_key: "networking"
      name: "Bastion"
      prefix_length: 28
```

## Example Module Reference

```yaml
module "public_ip_prefixes" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/public_ip_prefixes"
  for_each = {
    for key, value in try(local.settings.networking.public_ip_prefixes, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  public_ip_prefix    = each.value
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
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip_prefix.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_public_ip_prefix"></a> [public\_ip\_prefix](#input\_public\_ip\_prefix) | Configuration settings object for the Public IP Prefix resource | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Public IP Prefix |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Public IP Prefix |
<!-- END_TF_DOCS -->