
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_windows_function_app"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_windows_function_app" "functionapp" {
  name                       = module.resource_naming.name_result
  location                   = var.location != null ? var.location : var.global_settings.location
  resource_group_name        = var.resource_group_name
  tags                       = local.tags
  service_plan_id            = var.service_plan_id
  app_settings               = try(var.settings.app_settings, null)
  builtin_logging_enabled    = try(var.settings.builtin_logging_enabled, null)
  client_certificate_enabled = try(var.settings.client_certificate_enabled, null)
  client_certificate_mode    = try(var.settings.client_certificate_mode, null)
  # client_certificate_exclusion_paths = try(var.settings.client_certificate_exclusion_paths, null)
  daily_memory_time_quota         = try(var.settings.daily_memory_time_quota, null)
  enabled                         = try(var.settings.enabled, true)
  content_share_force_disabled    = try(var.settings.content_share_force_disabled, null)
  functions_extension_version     = try(var.settings.functions_extension_version, null)
  https_only                      = try(var.settings.https_only, null)
  key_vault_reference_identity_id = try(var.settings.identity.key_vault_reference_identity_id, null) != null ? try(var.managed_identities[var.settings.identity.key_vault_reference_identity_key].id, null) : null

  # One of storage_account_access_key or storage_uses_managed_identity must be specified when using storage_account_name
  storage_account_access_key = try(var.settings.sa_key, null) != null ? try(var.storage_accounts[var.settings.sa_key].primary_access_key, null) : try(var.settings.storage_account_access_key, null)
  storage_account_name       = try(var.settings.sa_key, null) != null ? try(var.storage_accounts[var.settings.sa_key].name, null) : try(var.settings.storage_account_name, null)
  # storage_uses_managed_identity   = try(var.settings.storage_uses_managed_identity, null)
  # storage_key_vault_secret_id     = try(var.settings.storage_key_vault_secret_id, null)

  virtual_network_subnet_id = try(coalesce(
    try(var.settings.subnet_id, null),
    try(var.virtual_networks[var.settings.vnet_key].subnets[var.settings.subnet_key].id, null)
  ), null)

  dynamic "backup" {
    for_each = lookup(var.settings, "backup", {}) == {} ? [] : [1]

    content {
      name                = var.settings.backup.name
      storage_account_url = var.settings.backup.storage_account_url
      enabled             = var.settings.backup.enabled

      dynamic "schedule" {
        for_each = lookup(var.settings.backup, "schedule", {}) == {} ? [] : [1]

        content {
          frequency_interval       = var.settings.backup.schedule.frequency_interval
          frequency_unit           = var.settings.backup.schedule.frequency_unit
          keep_at_least_one_backup = try(var.settings.backup.schedule.keep_at_least_one_backup, null)
          retention_period_days    = try(var.settings.backup.schedule.retention_period_days, null)
          start_time               = try(var.settings.backup.schedule.start_time, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, {}) == {} ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = concat(local.managed_identities, try(var.settings.identity.identity_ids, []))
    }
  }

  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) == {} ? [] : [1]

    content {
      enabled                        = try(var.settings.auth_settings.enabled, null)
      additional_login_parameters    = try(var.settings.auth_settings.additional_login_parameters, null)
      allowed_external_redirect_urls = try(var.settings.auth_settings.allowed_external_redirect_urls, null)
      default_provider               = try(var.settings.auth_settings.default_provider, null)
      issuer                         = try(var.settings.auth_settings.issuer, null)
      runtime_version                = try(var.settings.auth_settings.runtime_version, null)
      token_refresh_extension_hours  = try(var.settings.auth_settings.token_refresh_extension_hours, null)
      token_store_enabled            = try(var.settings.auth_settings.token_store_enabled, null)
      unauthenticated_client_action  = try(var.settings.auth_settings.unauthenticated_client_action, null)

      dynamic "active_directory" {
        for_each = lookup(var.settings.auth_settings, "active_directory", {}) == {} ? [] : [1]

        content {
          client_id                  = var.settings.auth_settings.active_directory.client_id
          allowed_audiences          = try(var.settings.auth_settings.active_directory.allowed_audiences, null)
          client_secret              = try(var.settings.auth_settings.active_directory.client_secret, null)
          client_secret_setting_name = try(var.settings.auth_settings.active_directory.client_secret_setting_name, null)
        }
      }

      dynamic "facebook" {
        for_each = lookup(var.settings.auth_settings, "facebook", {}) == {} ? [] : [1]

        content {
          app_id                  = var.settings.auth_settings.facebook.app_id
          app_secret              = try(var.settings.auth_settings.facebook.app_secret, null)
          app_secret_setting_name = try(var.settings.auth_settings.facebook.app_secret_setting_name, null)
          oauth_scopes            = try(var.settings.auth_settings.facebook.oauth_scopes, null)
        }
      }

      dynamic "github" {
        for_each = lookup(var.settings.auth_settings, "github", {}) == {} ? [] : [1]

        content {
          client_id                  = var.settings.auth_settings.github.client_id
          client_secret              = try(var.settings.auth_settings.github.client_secret, null)
          client_secret_setting_name = try(var.settings.auth_settings.github.client_secret_setting_name, null)
          oauth_scopes               = try(var.settings.auth_settings.github.oauth_scopes, null)
        }
      }

      dynamic "google" {
        for_each = lookup(var.settings.auth_settings, "google", {}) == {} ? [] : [1]

        content {
          client_id                  = var.settings.auth_settings.google.client_id
          client_secret              = try(var.settings.auth_settings.google.client_secret, null)
          client_secret_setting_name = try(var.settings.auth_settings.google.client_secret_setting_name, null)
          oauth_scopes               = try(var.settings.auth_settings.google.oauth_scopes, null)
        }
      }

      dynamic "microsoft" {
        for_each = lookup(var.settings.auth_settings, "microsoft", {}) == {} ? [] : [1]

        content {
          client_id                  = var.settings.auth_settings.microsoft.client_id
          client_secret              = try(var.settings.auth_settings.microsoft.client_secret, null)
          client_secret_setting_name = try(var.settings.auth_settings.microsoft.client_secret_setting_name, null)
          oauth_scopes               = try(var.settings.auth_settings.microsoft.oauth_scopes, null)
        }
      }

      dynamic "twitter" {
        for_each = lookup(var.settings.auth_settings, "twitter", {}) == {} ? [] : [1]

        content {
          consumer_key                 = var.settings.auth_settings.twitter.consumer_key
          consumer_secret              = try(var.settings.auth_settings.twitter.consumer_secret, null)
          consumer_secret_setting_name = try(var.settings.auth_settings.twitter.consumer_secret_setting_name, null)
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = try(var.settings.connection_strings, {})

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "sticky_settings" {
    for_each = lookup(var.settings, "sticky_settings", {}) == {} ? [] : [1]

    content {
      app_setting_names       = try(var.settings.sticky_settings.app_setting_names, null)
      connection_string_names = try(var.settings.sticky_settings.connection_string_names, null)
    }
  }

  site_config {
    always_on                              = try(var.settings.site_config.always_on, null)
    api_definition_url                     = try(var.settings.site_config.api_definition_url, null)
    api_management_api_id                  = try(var.settings.site_config.api_management_api_id, null)
    app_command_line                       = try(var.settings.site_config.app_command_line, null)
    app_scale_limit                        = try(var.settings.site_config.app_scale_limit, null)
    application_insights_connection_string = try(var.settings.site_config.application_insights_connection_string, null)
    application_insights_key               = try(var.settings.site_config.application_insights_key, null)
    default_documents                      = try(var.settings.site_config.default_documents, null)
    elastic_instance_minimum               = try(var.settings.site_config.elastic_instance_minimum, null)
    ftps_state                             = try(var.settings.site_config.ftps_state, null)
    health_check_path                      = try(var.settings.site_config.health_check_path, null)
    health_check_eviction_time_in_min      = try(var.settings.site_config.health_check_eviction_time_in_min, null)
    http2_enabled                          = try(var.settings.site_config.http2_enabled, null)
    load_balancing_mode                    = try(var.settings.site_config.load_balancing_mode, null)
    managed_pipeline_mode                  = try(var.settings.site_config.managed_pipeline_mode, null)
    minimum_tls_version                    = try(var.settings.site_config.minimum_tls_version, null)
    pre_warmed_instance_count              = try(var.settings.site_config.pre_warmed_instance_count, null)
    remote_debugging_enabled               = try(var.settings.site_config.remote_debugging_enabled, null)
    remote_debugging_version               = try(var.settings.site_config.remote_debugging_version, null)
    runtime_scale_monitoring_enabled       = try(var.settings.site_config.runtime_scale_monitoring_enabled, null)
    scm_minimum_tls_version                = try(var.settings.site_config.scm_minimum_tls_version, null)
    scm_use_main_ip_restriction            = try(var.settings.site_config.scm_use_main_ip_restriction, null)
    use_32_bit_worker                      = try(var.settings.site_config.use_32_bit_worker, null)
    vnet_route_all_enabled                 = try(var.settings.site_config.vnet_route_all_enabled, null)
    websockets_enabled                     = try(var.settings.site_config.websockets_enabled, null)
    worker_count                           = try(var.settings.site_config.worker_count, null)

    dynamic "application_stack" {
      for_each = lookup(var.settings.site_config, "application_stack", {}) == {} ? [] : [1]

      content {
        dotnet_version              = try(var.settings.site_config.application_stack.dotnet_version, null)
        use_dotnet_isolated_runtime = try(var.settings.site_config.application_stack.use_dotnet_isolated_runtime, null)
        java_version                = try(var.settings.site_config.application_stack.java_version, null)
        node_version                = try(var.settings.site_config.application_stack.node_version, null)
        powershell_core_version     = try(var.settings.site_config.application_stack.powershell_core_version, null)
        use_custom_runtime          = try(var.settings.site_config.application_stack.use_custom_runtime, null)
      }
    }

    dynamic "app_service_logs" {
      for_each = lookup(var.settings.site_config, "app_service_logs", {}) == {} ? [] : [1]

      content {
        disk_quota_mb         = try(var.settings.site_config.app_service_logs.disk_quota_mb, null)
        retention_period_days = try(var.settings.site_config.app_service_logs.retention_period_days, null)
      }
    }

    dynamic "cors" {
      for_each = lookup(var.settings.site_config, "cors", {}) == {} ? [] : [1]

      content {
        allowed_origins     = var.settings.site_config.cors.allowed_origins
        support_credentials = try(var.settings.site_config.cors.support_credentials, null)
      }
    }

    dynamic "ip_restriction" {
      for_each = try(var.settings.site_config.ip_restrictions, {})

      content {
        action      = try(ip_restriction.value.action, null)
        ip_address  = try(ip_restriction.value.ip_address, null)
        name        = try(ip_restriction.value.name, null)
        priority    = try(ip_restriction.value.priority, null)
        service_tag = try(ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(coalesce(
          try(ip_restriction.value.subnet_id, null),
          try(var.virtual_networks[ip_restriction.value.vnet_key].subnets[ip_restriction.value.subnet_key].id, null)
        ), null)

        dynamic "headers" {
          for_each = lookup(ip_restriction.value, "headers", {}) == {} ? [] : [1]

          content {
            x_azure_fdid      = try(ip_restriction.value.headers.x_azure_fdid, null)
            x_fd_health_probe = try(ip_restriction.value.headers.x_fd_health_probe, null)
            x_forwarded_for   = try(ip_restriction.value.headers.x_forwarded_for, null)
            x_forwarded_host  = try(ip_restriction.value.headers.x_forwarded_host, null)
          }
        }
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = try(var.settings.site_config.scm_ip_restrictions, {})

      content {
        action      = try(scm_ip_restriction.value.action, null)
        ip_address  = try(scm_ip_restriction.value.ip_address, null)
        name        = try(scm_ip_restriction.value.name, null)
        priority    = try(scm_ip_restriction.value.priority, null)
        service_tag = try(scm_ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(coalesce(
          try(scm_ip_restriction.value.subnet_id, null),
          try(var.virtual_networks[scm_ip_restriction.value.vnet_key].subnets[scm_ip_restriction.value.subnet_key].id, null)
        ), null)

        dynamic "headers" {
          for_each = lookup(scm_ip_restriction.value, "headers", {}) == {} ? [] : [1]

          content {
            x_azure_fdid      = try(scm_ip_restriction.value.headers.x_azure_fdid, null)
            x_fd_health_probe = try(scm_ip_restriction.value.headers.x_fd_health_probe, null)
            x_forwarded_for   = try(scm_ip_restriction.value.headers.x_forwarded_for, null)
            x_forwarded_host  = try(scm_ip_restriction.value.headers.x_forwarded_host, null)
          }
        }
      }
    }

  }

}
