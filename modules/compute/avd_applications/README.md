# Azure Virtual Desktop Application

## Default Naming Convention
```
name_mask = "{name}"

Example Result: ChromeApp
```

## Example Settings
```yaml
azure_virtual_desktops:
  host_pools:
    hostpool1:
      enabled: true
      resource_group_key: "avd"
      name: "HOSTPOOL"
      type: "Pooled"
      load_balancer_type: "BreadthFirst"
      friendly_name: "AVD Host Pool"
      registration_info:
        rotation_days: 30
  workspaces:
    workspace1:
      enabled: true
      resource_group_key: "avd"
      name: "WORKSPACE"
  application_groups:
    appgroup1:
      enabled: true
      resource_group_key: "avd"
      host_pool_key: "hostpool1"
      workspace_key: "workspace1"
      type: "Desktop"
      name: "APPGROUP"
  applications:
    app1:
      enabled: true
      name: "ChromeApp"
      app_group_key: "appgroup1"
      friendly_name: "Google Chrome"
      description: "Chromium based web browser"
      path: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
      command_line_argument_policy: "DoNotAllow"
      command_line_arguments: "--incognito"
      show_in_portal: false
      icon_path: "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
      icon_index: 0

```

## Example Module Reference

```yaml
module "avd_applications" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/compute/avd_applications"
  for_each = {
    for key, value in try(local.settings.azure_virtual_desktops.applications, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings      = local.settings
  settings             = each.value
  application_group_id = module.avd_app_groups[each.value.app_group_key].id
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
| [azurerm_virtual_desktop_application.da](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_group_id"></a> [application\_group\_id](#input\_application\_group\_id) | Resource ID for a AVD Application Group to associate with the AVD Application | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the AVD Application resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Application |
<!-- END_TF_DOCS -->