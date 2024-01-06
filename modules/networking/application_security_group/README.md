# Application Security Group

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{asg}{delimiter}{postfix}"

Example Result: AVA-DEMO-CUS-CORP-PROD-ASG-01
```

## Example Settings
```yaml
networking:  
  application_security_groups:
    asg1:
      naming_convention:
        postfix: "01"
      enabled: true
      resource_group_key: "networking"
```

## Example Module Reference

```yaml
module "app_security_groups" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/application_security_group"
  for_each = {
    for key, value in try(local.settings.networking.application_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reused, false) == false
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
| [azurerm_application_security_group.asg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Application Security Group resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Application Security Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Application Security Group |
<!-- END_TF_DOCS -->