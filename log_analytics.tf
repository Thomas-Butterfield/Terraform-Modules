module "log_analytics" {
  source = "./modules/log_analytics"
  for_each = {
    for key, value in try(local.settings.loganalytics, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  log_analytics       = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "log_analytics_reused" {
  source = "./modules/log_analytics_reused"
  providers = {
    azurerm                    = azurerm
    azurerm.sharedsvc_provider = azurerm.sharedsvc_subscription
  }

  for_each = {
    for key, value in try(local.settings.loganalytics, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  name                = each.value.name
  resource_group_name = each.value.rg_name
}
