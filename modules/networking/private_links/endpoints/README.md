# Private Endpoint

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{privateendpoint}{delimiter}{name}"

Example Result: AVA-EUS2-DEV-PRVENDPNT-BLOB
```

## Example Settings
```yaml
private_endpoints:
  pe1:
    enabled: true
    vnet_key: "vnet1"
    subnet_keys: ["subnet2"]
    resource_group_key: "networking" # Key of resource group of the vnet
    storage_accounts:
      st1:
        storage_account_key: "st1"
        resource_group_key: "networking" # If not provided, PE RG will be VNet RG
        private_service_connection:
          name: "psc1"
          subresource_name: "blob" # only one subresource name at a time. Need to create a new PEndpoint node to create for something else                
        private_dns:
          blob: # **Must match key of subresource_names
            name: "blob.core.windows.net"
            private_dns_records:
              a_records:
                arec1:
                  name: "storageAccount"
                  use_resource_name: true

# Both attributes need to be set to false as shown below before creating/assigning a new Private Endpoint to an existing VNet/Subnet
subnet2:
    # Enabling Private Endpoint in this subnet
    private_endpoint_network_policies_enabled: false
    private_link_service_network_policies_enabled: false                  
```

## Example Module Reference

```yaml
module "private_endpoints" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/private_links/endpoints"
  for_each = {
    for key, value in try(local.settings.networking.private_endpoints, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings  = local.settings
  private_endpoint = each.value
  resource_groups  = local.resource_groups
  vnet             = module.networking[each.value.vnet_key]
  tags             = try(each.value.tags, null)

  remote_objects = local.privendpoint_remote_objects
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./subnet | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | Private DNS settings map object. Used only if already managing private DNS outside of this object. | `map` | `{}` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | Configuration settings object for the Private Endpoint resource | `any` | n/a | yes |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | Module objects used to retrieve IDs from var.private\_endpoint keys | `any` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Resource Groups module object | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | VNet module object - instance of specific VNet used for the Private Endpoint | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet"></a> [subnet](#output\_subnet) | n/a |
<!-- END_TF_DOCS -->