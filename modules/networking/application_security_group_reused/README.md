# Application Security Group Data Resource

## Example Settings
```yaml
networking:  
  application_security_groups:
    asg1:
      enabled: true
      rg_name: "AVA-DEMO-CUS-CORP-PROD-NETWORK-RG"
      name: "AVA-DEMO-CUS-CORP-PROD-ASG-01"
      reused: true
```

## Example Module Reference

```yaml
module "app_security_groups_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/application_security_group_reused"
  for_each = {
    for key, value in try(local.settings.networking.application_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reused, false) == true
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
| [azurerm_application_security_group.asg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Application Security Group resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Application Security Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Application Security Group |
<!-- END_TF_DOCS -->