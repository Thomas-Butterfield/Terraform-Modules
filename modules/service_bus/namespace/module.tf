locals {
  tags = merge(var.global_settings.tags, var.tags)

  # The namespace name should adhere to the following naming conventions:

  #   The name must be unique across Azure. The system immediately checks to see if the name is available.
  #   The name length is at least 6 and at most 50 characters.
  #   The name can contain only letters, numbers, hyphens “-“.
  #   The name must start with a letter and end with a letter or number.
  #   The name doesn't end with “-sb“ or “-mgmt“.

  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{sbus_ns}{delimiter}{postfix}"

  managed_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_namespace"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_namespace" "namespace" {
  name                          = module.resource_naming.name_result
  location                      = var.location != null ? var.location : var.global_settings.location
  resource_group_name           = var.resource_group_name
  tags                          = local.tags
  sku                           = var.settings.sku
  capacity                      = var.settings.sku == "Basic" || var.settings.sku == "Standard" ? "0" : try(var.settings.capacity, null)
  local_auth_enabled            = try(var.settings.local_auth_enabled, true)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  minimum_tls_version           = try(var.settings.minimum_tls_version, "1.2")
  zone_redundant                = try(var.settings.zone_redundant, false)

  ## SystemAssigned, UserAssigned, "SystemAssigned, UserAssigned" (to enable both)
  dynamic "identity" {
    for_each = try(var.settings.identity, {}) == {} ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = concat(local.managed_identities, try(var.settings.identity.identity_ids, []))
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.settings.customer_managed_key, {}) == {} ? [] : [1]

    content {
      identity_id                       = try(var.settings.customer_managed_key.user_assigned_identity_key, null) != null ? try(var.managed_identities[var.settings.customer_managed_key.user_assigned_identity_key].id, null) : null
      key_vault_key_id                  = try(var.settings.customer_managed_key.key_id_key, null) != null ? try(var.key_vault_keys[var.settings.customer_managed_key.key_id_key].id, null) : null
      infrastructure_encryption_enabled = try(var.settings.customer_managed_key.infrastructure_encryption_enabled, null)
    }
  }

}
