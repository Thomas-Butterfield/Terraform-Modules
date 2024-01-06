
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{data_factory}{delimiter}{postfix}"

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
  resource_type   = "azurerm_data_factory"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_data_factory" "df" {
  name                            = module.resource_naming.name_result
  location                        = var.location != null ? var.location : var.global_settings.location
  resource_group_name             = var.resource_group_name
  managed_virtual_network_enabled = try(var.settings.managed_virtual_network_enabled, null)
  public_network_enabled          = try(var.settings.public_network_enabled, null)
  customer_managed_key_id         = try(var.settings.customer_managed_key_id, null)
  customer_managed_key_identity_id = try(var.settings.customer_managed_key_identity_id, null) == null ? null : coalesce(var.settings.customer_managed_key_identity_id, try(var.key_vault_keys[var.settings.customer_managed_key_identity_key].id, null)
  )
  tags = local.tags

  dynamic "github_configuration" {
    for_each = try(var.settings.github_configuration, null) != null ? [var.settings.github_configuration] : []

    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }

  dynamic "global_parameter" {
    for_each = try(var.settings.global_parameter, null) != null ? [var.settings.vsts_configuration] : []

    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, {}) == {} ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = concat(local.managed_identities, try(var.settings.identity.identity_ids, []))
    }
  }

  dynamic "vsts_configuration" {
    for_each = try(var.settings.vsts_configuration, null) != null ? [var.settings.vsts_configuration] : []

    content {
      account_name    = vsts_configuration.value.account_name
      branch_name     = vsts_configuration.value.branch_name
      project_name    = vsts_configuration.value.project_name
      repository_name = vsts_configuration.value.repository_name
      root_folder     = vsts_configuration.value.root_folder
      tenant_id       = vsts_configuration.value.tenant_id
    }
  }

}
