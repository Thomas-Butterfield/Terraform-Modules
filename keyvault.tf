module "keyvault" {
  source = "./modules/security/keyvault"
  for_each = {
    for key, value in try(local.settings.keyvaults, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  key_vault           = each.value
  tenant_id           = var.tenant_id
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "keyvault_reused" {
  source = "./modules/security/keyvault_reused"
  for_each = {
    for key, value in try(local.settings.keyvaults, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings = local.settings
  key_vault       = each.value
  tenant_id       = var.tenant_id
}

module "keyvault_access_policies" {
  source = "./modules/security/keyvault_access_policies"
  for_each = {
    for key, value in try(local.settings.keyvault_access_policies, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  keyvaults       = module.keyvault
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  access_policies = each.value
}
