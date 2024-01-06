module "storage_account" {
  source = "../private_endpoint"
  for_each = {
    for key, value in try(var.private_endpoints.storage_accounts, {}) : key => value
  }
  global_settings     = var.global_settings
  settings            = each.value
  resource_id         = can(each.value.resource_id) ? each.value.resource_id : var.remote_objects.storage_accounts[try(each.value.storage_account_key, each.key)].id
  resource_name       = can(each.value.resource_name) ? each.value.resource_name : var.remote_objects.storage_accounts[try(each.value.storage_account_key, each.key)].name
  subresource_name    = try(each.value.private_service_connection.subresource_names, "file")
  subnet_id           = var.subnet_id
  vnet_id             = var.vnet_id
  private_dns         = var.private_dns
  resource_group_name = can(each.value.resource_group_key) ? var.resource_groups[each.value.resource_group_key].name : var.vnet_resource_group_name
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  tags                = var.tags
}
