module "roles" {
  source = "./modules/security/roles/role_assignment"
  for_each = {
    for key, value in try(local.settings.role_assignments, {}) : key => value
    if try(value.enabled, false) == true
  }

  # global_settings     = local.settings
  #depends_on                 = [module.managed_identity]
  scope              = each.value.scope == "resourcegroup" ? local.resource_groups[each.value.scope_key].id : each.value.scope == "subscription" ? data.azurerm_subscription.primary.id : each.value.scope == "storage" ? module.storage_account[each.value.scope_key].id : each.value.scope == "appgroup" ? module.avd_app_groups[each.value.scope_key].id : null
  mode               = each.value.mode
  role_mappings      = try(each.value.role_mappings, {})
  azuread_groups     = local.azuread_groups
  custom_roles       = module.custom_role
  managed_identities = module.managed_identity
}