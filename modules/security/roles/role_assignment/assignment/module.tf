
resource "azurerm_role_assignment" "object_id" {
  for_each = {
    for key in lookup(var.keys, "object_ids", {}) : key => key
  }

  scope                = var.scope
  role_definition_name = var.role_definition_name == null ? null : var.role_definition_name
  role_definition_id   = var.role_definition_id == null ? null : var.role_definition_id
  principal_id         = each.value == "logged_in_user" || each.value == "logged_in_aad_app" ? var.client_config.object_id : each.value
}

resource "azurerm_role_assignment" "azuread_apps" {
  for_each = {
    for key in lookup(var.keys, "azuread_app_keys", {}) : key => key
  }

  scope                = var.scope
  role_definition_name = var.role_definition_name == null ? null : var.role_definition_name
  role_definition_id   = var.role_definition_id == null ? null : var.role_definition_id
  principal_id         = var.azuread_apps[each.value].azuread_service_principal.object_id
}

resource "azurerm_role_assignment" "azuread_service_principals" {
  for_each = {
    for key in lookup(var.keys, "azuread_service_principal_keys", {}) : key => key
  }

  scope                = var.scope
  role_definition_name = var.role_definition_name == null ? null : var.role_definition_name
  role_definition_id   = var.role_definition_id == null ? null : var.role_definition_id
  principal_id         = var.azuread_service_principals[each.value].object_id
}

resource "azurerm_role_assignment" "azuread_group" {
  for_each = {
    for key in lookup(var.keys, "azuread_group_keys", {}) : key => key
  }

  scope                = var.scope
  role_definition_name = var.role_definition_name == null ? null : var.role_definition_name
  role_definition_id   = var.role_definition_id == null ? null : var.role_definition_id
  principal_id         = var.azuread_groups[each.value].object_id
}

resource "azurerm_role_assignment" "msi" {
  for_each = {
    for key in lookup(var.keys, "managed_identity_keys", {}) : key => key
  }

  scope                = var.scope
  role_definition_name = var.role_definition_name == null ? null : var.role_definition_name
  role_definition_id   = var.role_definition_id == null ? null : var.role_definition_id
  principal_id         = var.managed_identities[each.value].principal_id
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azurerm_role_assignment.object_id,
    azurerm_role_assignment.azuread_apps,
    azurerm_role_assignment.azuread_service_principals,
    azurerm_role_assignment.azuread_group,
    azurerm_role_assignment.msi
  ]

  create_duration = "60s"
}
