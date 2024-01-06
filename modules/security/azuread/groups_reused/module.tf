
data "azuread_group" "group" {
  display_name     = lookup(var.azuread_group, "name", null)
  object_id        = lookup(var.azuread_group, "object_id", null)
  security_enabled = lookup(var.azuread_group, "security_enabled", null)
}
