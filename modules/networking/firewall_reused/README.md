# Azure Firewall Data Resource

## Example Settings
```yaml
networking:  
  azfirewalls:
    #hub firewall
    azfw1:
      enabled: true
      reuse: true
      use_sharedsvc_provider: true
      name: "AVA-SCUS-CONNECT-TST-AZFW"
      rg_name: "AVA-SCUS-CONNECT-TST-NETWORK-RG"
```

## Example Module Reference

```yaml
module "firewall_reused" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/firewall_reused"
  providers = {
    azurerm = azurerm.hub_subscription
  }

  for_each = {
    for key, value in try(local.settings.networking.firewall, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true && try(value.use_sharedsvc_provider, false) == true
  }

  firewall = each.value
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
| [azurerm_firewall.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/firewall) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Configuration settings object for the Azure Firewall resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall data resource |
| <a name="output_ip_configuration"></a> [ip\_configuration](#output\_ip\_configuration) | The IP Configuration (Private IP Address) of the Azure Firewall data resource |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Azure Firewall data resource |
<!-- END_TF_DOCS -->