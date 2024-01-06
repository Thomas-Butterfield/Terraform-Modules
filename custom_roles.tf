module "custom_role" {
  source = "./modules/security/roles/custom_roles"
  for_each = {
    for key, value in try(local.settings.custom_roles, {}) : key => value
    if try(value.enabled, false) == true
  }
  global_settings      = local.settings
  settings             = try(each.value, null)
  subscription_primary = data.azurerm_subscription.primary.id
  assignable_scopes    = try(each.value.permissions.scopes, null)

}