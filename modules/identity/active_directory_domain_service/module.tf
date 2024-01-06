
locals {
  tags = merge(var.global_settings.tags, var.tags)
  # name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{aadds}{delimiter}{name}"
  name_mask = "{name}" # Typically use the domain_name value as the name
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_active_directory_domain_service"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_active_directory_domain_service" "aadds" {
  name                      = module.resource_naming.name_result
  location                  = var.location != null ? var.location : var.global_settings.location
  resource_group_name       = var.resource_group_name
  domain_name               = var.settings.domain_name
  domain_configuration_type = try(var.settings.domain_configuration_type, null)
  filtered_sync_enabled     = try(var.settings.filtered_sync_enabled, null)
  sku                       = var.settings.sku
  tags                      = local.tags

  dynamic "secure_ldap" {
    for_each = try(var.settings.secure_ldap, null) != null ? [var.settings.secure_ldap] : []
    content {
      enabled                  = try(secure_ldap.value.enabled, null)
      external_access_enabled  = try(secure_ldap.value.external_access_enabled, null)
      pfx_certificate          = try(secure_ldap.value.pfx_certificate, null)
      pfx_certificate_password = try(secure_ldap.value.pfx_certificate_password, null)
    }
  }

  dynamic "notifications" {
    for_each = try(var.settings.notifications, null) != null ? [var.settings.notifications] : []
    content {
      additional_recipients = try(notifications.value.additional_recipients, null)
      notify_dc_admins      = try(notifications.value.notify_dc_admins, null)
      notify_global_admins  = try(notifications.value.notify_global_admins, null)
    }
  }

  dynamic "initial_replica_set" {
    for_each = try(var.settings.initial_replica_set, null) != null ? [var.settings.initial_replica_set] : []
    content {
      subnet_id = coalesce(
        try(var.virtual_networks[initial_replica_set.value.subnet.vnet_key].subnets[initial_replica_set.value.subnet.subnet_key].id, null),
        try(initial_replica_set.subnet.value.subnet_id, null)
      )
    }
  }

  dynamic "security" {
    for_each = try(var.settings.security, null) != null ? [var.settings.security] : []
    content {
      ntlm_v1_enabled         = try(security.value.ntlm_v1_enabled, null)
      sync_kerberos_passwords = try(security.value.sync_kerberos_passwords, null)
      sync_ntlm_passwords     = try(security.value.sync_ntlm_passwords, null)
      sync_on_prem_passwords  = try(security.value.sync_on_prem_passwords, null)
      tls_v1_enabled          = try(security.value.tls_v1_enabled, null)
    }
  }

  lifecycle {
    ignore_changes = [
      initial_replica_set[0].subnet_id
    ]
  }

  timeouts {
    create = "2h"
    update = "3h"
    delete = "3h"
    read   = "5m"
  }

}
