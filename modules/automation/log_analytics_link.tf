resource "azurerm_log_analytics_linked_service" "auto_account_la_link" {
  for_each = try(var.automation_account.log_analytics_links, {})

  # RG needs to be the LA Workspace RG for the workspace_id lookup to work
  resource_group_name = var.log_analytics[each.value.log_analytics_key].resource_group_name
  workspace_id        = var.log_analytics[each.value.log_analytics_key].id
  read_access_id      = azurerm_automation_account.auto_account.id
}
