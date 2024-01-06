# Bastion Host

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{bastion}"

Example Result: AVA-EUS2-DEV-BAS
```

## Example Settings
```yaml
networking:  
  bastion_hosts:
    # If multiple, override the naming mask to apply postfix and/or add name to object
    host1:
      enabled: true
      resource_group_key: "networking"
      public_ip_address_key: "pipbastion"
      vnet_key: "vnet1"
      subnet_key: "subnet4"
```

## Example Module Reference

```yaml
module "bastion_host" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/bastion_host"
  for_each = {
    for key, value in try(local.settings.networking.bastion_hosts, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings      = local.settings
  resource_group_name  = local.resource_groups[each.value.resource_group_key].name
  bastion_subnet_id    = module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id
  public_ip_address_id = module.public_ip_address[each.value.public_ip_address_key].id
  bastion_host         = each.value
  tags                 = try(each.value.tags, null)
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
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_host"></a> [bastion\_host](#input\_bastion\_host) | Configuration settings object for the Bastion Host resource | `any` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | Reference to a subnet in which this Bastion Host has been created (**Must be created in advance) | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | Reference to a Public IP Address to associate with this Bastion Host (**Must be created in advance) | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Bastion Host |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Bastion Host |
<!-- END_TF_DOCS -->