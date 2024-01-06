
resource "azuread_group" "group" {
  display_name            = var.azuread_group.name
  description             = lookup(var.azuread_group, "description", null)
  prevent_duplicate_names = lookup(var.azuread_group, "prevent_duplicate_names", false)
  security_enabled        = lookup(var.azuread_group, "security_enabled", true)
  owners = coalescelist(
    try(tolist(var.azuread_group.owners), []),
    [
      var.client_config.object_id
    ]
  )
}
