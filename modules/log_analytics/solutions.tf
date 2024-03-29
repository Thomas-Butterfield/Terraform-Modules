resource "azurerm_log_analytics_solution" "solution" {
  for_each = {
    for key, value in try(var.log_analytics.solutions, {}) : key => value
    if try(value.enabled, false) == true
  }

  solution_name         = each.value.name
  location              = var.global_settings.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  tags                  = local.tags

  plan {
    publisher      = lookup(each.value, "publisher")
    product        = lookup(each.value, "product")
    promotion_code = lookup(each.value, "promotion_code", null)
  }
}
