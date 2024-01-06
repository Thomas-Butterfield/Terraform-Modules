##=====================================================
## Process membership for var.azuread_groups_membership
##
## Groups memberships referencing lists at var.settings
##=====================================================

module "azuread_service_principals_membership" {
  source   = "./membership"
  for_each = try(var.settings.azuread_service_principals, {})

  azuread_service_principals = var.azuread_service_principals
  members                    = each.value
  group_object_id            = try(var.azuread_groups[var.group_key].id, null)
}

module "managed_identities_membership" {
  source   = "./membership"
  for_each = try(var.settings.managed_identities, {})

  managed_identities = var.managed_identities
  members            = each.value
  group_object_id    = try(var.azuread_groups[var.group_key].id, null)
}

module "mssql_servers_membership" {
  source   = "./membership"
  for_each = try(var.settings.mssql_servers, {})

  mssql_servers   = var.mssql_servers
  members         = each.value
  group_object_id = try(var.azuread_groups[var.group_key].id, null)
}

module "membership_object_id" {
  source = "./member"
  for_each = {
    for key, value in try(var.settings.object_ids, {}) : key => value
    if key != "logged_in"
  }

  group_object_id = coalesce(
    try(var.azuread_groups[var.group_key].id, null),
    var.group_id
  )
  member_object_id = each.value
}

module "membership_logged_in_object_id" {
  source = "./member"
  for_each = {
    for key, value in try(var.settings.object_ids, {}) : key => value
    if key == "logged_in"
  }

  group_object_id = coalesce(
    try(var.azuread_groups[var.group_key].id, null),
    var.group_id
  )
  member_object_id = var.client_config.object_id
}
