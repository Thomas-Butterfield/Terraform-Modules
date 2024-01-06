locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{mlci}"

  managed_identities = flatten([
    for managed_identity_key in try(var.ml_compute_instance.identity.managed_identity_keys, []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])

}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.ml_compute_instance
  resource_type   = "azurerm_machine_learning_compute_instance"
  name_mask       = try(var.ml_compute_instance.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_machine_learning_compute_instance" "mlci" {
  name                          = module.resource_naming.name_result
  location                      = var.location != null ? var.location : var.global_settings.location
  machine_learning_workspace_id = var.machine_learning_workspace_id
  virtual_machine_size          = var.ml_compute_instance.virtual_machine_size
  authorization_type            = try(var.ml_compute_instance.authorization_type, null)
  description                   = try(var.ml_compute_instance.description, null)
  subnet_resource_id            = try(var.subnet_resource_id, null)
  local_auth_enabled            = try(var.ml_compute_instance.local_auth_enabled, true)
  tags                          = local.tags

  dynamic "assign_to_user" {
    for_each = try(var.ml_compute_instance.assign_to_user, null) != null ? [var.ml_compute_instance.assign_to_user] : []

    content {
      object_id = assign_to_user.value.object_id
      tenant_id = coalesce(
        try(var.tenant_id, null),
        var.client_config.tenant_id
      )
    }
  }

  dynamic "identity" {
    for_each = try(var.ml_compute_instance.identity, null) != null ? [var.ml_compute_instance.identity] : []

    content {
      type         = identity.value.type
      identity_ids = concat(local.managed_identities, try(var.ml_compute_instance.identity.identity_ids, []))
    }

  }

  dynamic "ssh" {
    for_each = try(var.ml_compute_instance.ssh, null) != null ? [var.ml_compute_instance.ssh] : []

    content {
      public_key = try(ssh.value.ssh_key, null) != null ? var.ssh_keys[ssh.value.ssh_key].public_key : abspath(var.ml_compute_instance.ssh.public_key)
    }
  }

  timeouts {
    create = "60m"
    delete = "120m"
  }

}
