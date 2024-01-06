module "azuread_groups" {
  source = "./modules/security/azuread/groups"
  for_each = {
    for key, value in try(local.settings.azuread.groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  # global_settings     = local.settings
  azuread_group = each.value
  tenant_id     = var.tenant_id
  client_config = data.azurerm_client_config.current
}

module "azuread_groups_reused" {
  source = "./modules/security/azuread/groups_reused"
  for_each = {
    for key, value in try(local.settings.azuread.groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  # global_settings     = local.settings
  azuread_group = each.value
  tenant_id     = var.tenant_id
  client_config = data.azurerm_client_config.current
}
