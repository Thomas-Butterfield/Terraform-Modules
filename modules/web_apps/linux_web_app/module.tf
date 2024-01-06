
locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_linux_web_app"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_linux_web_app" "webapp" {
  name                       = module.resource_naming.name_result
  location                   = var.location != null ? var.location : var.global_settings.location
  resource_group_name        = var.resource_group_name
  tags                       = local.tags
  service_plan_id            = var.service_plan_id
  app_settings               = try(var.settings.app_settings, null)
  client_affinity_enabled    = try(var.settings.client_affinity_enabled, null)
  client_certificate_enabled = try(var.settings.client_certificate_enabled, null)
  client_certificate_mode    = try(var.settings.client_certificate_mode, null)
  # client_certificate_exclusion_paths = try(var.settings.client_certificate_exclusion_paths, null)
  enabled                         = try(var.settings.enabled, true)
  https_only                      = try(var.settings.https_only, null)
  key_vault_reference_identity_id = try(var.settings.identity.key_vault_reference_identity_id, null) != null ? try(var.managed_identities[var.settings.identity.key_vault_reference_identity_key].id, null) : null
  zip_deploy_file                 = try(var.settings.zip_deploy_file, null)

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
      identity_ids = concat(var.managed_identities, try(var.settings.identity.identity_ids, []))
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

  dynamic "logs" {
    for_each = lookup(var.settings, "logs", {}) == {} ? [] : [1]

    content {
      detailed_error_messages = try(var.settings.logs.detailed_error_messages, null)
      failed_request_tracing  = try(var.settings.logs.failed_request_tracing, null)

      dynamic "application_logs" {
        for_each = lookup(var.settings.logs, "application_logs", {}) == {} ? [] : [1]

        content {

          file_system_level = var.settings.logs.application_logs.file_system_level

          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.application_logs, "azure_blob_storage", {}) == {} ? [] : [1]

            content {
              level             = var.settings.logs.application_logs.azure_blob_storage.level
              retention_in_days = var.settings.logs.application_logs.azure_blob_storage.retention_in_days
              sas_url           = var.settings.logs.application_logs.azure_blob_storage.sas_url
            }
          }
        }
      }

      dynamic "http_logs" {
        for_each = lookup(var.settings.logs, "http_logs", {}) == {} ? [] : [1]

        content {

          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.http_logs, "azure_blob_storage", {}) == {} ? [] : [1]

            content {
              retention_in_days = var.settings.logs.application_logs.azure_blob_storage.retention_in_days
              sas_url           = var.settings.logs.application_logs.azure_blob_storage.sas_url
            }
          }

          dynamic "file_system" {
            for_each = lookup(var.settings.logs.http_logs, "file_system", {}) == {} ? [] : [1]

            content {
              retention_in_days = var.settings.logs.http_logs.file_system.retention_in_days
              retention_in_mb   = var.settings.logs.http_logs.file_system.retention_in_mb
            }
          }
        }
      }

    }
  }

  dynamic "storage_account" {
    for_each = try(var.settings.storage_accounts, {})

    content {
      access_key   = coalesce(storage_account.value.access_key, try(var.storage_accounts[storage_account.value.sa_key].primary_access_key, null))
      account_name = coalesce(storage_account.value.account_name, try(var.storage_accounts[storage_account.value.sa_key].name, null))
      name         = try(storage_account.value.name, null)
      share_name   = try(storage_account.value.share_name, null)
      type         = try(storage_account.value.type, null)
      mount_path   = try(storage_account.value.mount_path, null)
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
    always_on                                     = try(var.settings.site_config.always_on, null)
    api_definition_url                            = try(var.settings.site_config.api_definition_url, null)
    api_management_api_id                         = try(var.settings.site_config.api_management_api_id, null)
    app_command_line                              = try(var.settings.site_config.app_command_line, null)
    auto_heal_enabled                             = try(var.settings.site_config.auto_heal_enabled, null)
    container_registry_managed_identity_client_id = try(var.settings.site_config.container_registry_managed_identity_client_id, null)
    container_registry_use_managed_identity       = try(var.settings.site_config.container_registry_use_managed_identity, null)
    default_documents                             = try(var.settings.site_config.default_documents, null)
    ftps_state                                    = try(var.settings.site_config.ftps_state, null)
    health_check_path                             = try(var.settings.site_config.health_check_path, null)
    health_check_eviction_time_in_min             = try(var.settings.site_config.health_check_eviction_time_in_min, null)
    http2_enabled                                 = try(var.settings.site_config.http2_enabled, null)
    load_balancing_mode                           = try(var.settings.site_config.load_balancing_mode, null)
    local_mysql_enabled                           = try(var.settings.site_config.local_mysql_enabled, null)
    managed_pipeline_mode                         = try(var.settings.site_config.managed_pipeline_mode, null)
    minimum_tls_version                           = try(var.settings.site_config.minimum_tls_version, null)
    # remote_debugging                              = try(var.settings.site_config.remote_debugging, null)
    remote_debugging_version    = try(var.settings.site_config.remote_debugging_version, null)
    scm_minimum_tls_version     = try(var.settings.site_config.scm_minimum_tls_version, null)
    scm_use_main_ip_restriction = try(var.settings.site_config.scm_use_main_ip_restriction, null)
    use_32_bit_worker           = try(var.settings.site_config.use_32_bit_worker, null)
    vnet_route_all_enabled      = try(var.settings.site_config.vnet_route_all_enabled, null)
    websockets_enabled          = try(var.settings.site_config.websockets_enabled, null)
    worker_count                = try(var.settings.site_config.worker_count, null)

    dynamic "application_stack" {
      for_each = lookup(var.settings.site_config, "application_stack", {}) == {} ? [] : [1]

      content {
        docker_image        = try(var.settings.site_config.application_stack.docker_image, null)
        docker_image_tag    = try(var.settings.site_config.application_stack.docker_image_tag, null)
        dotnet_version      = try(var.settings.site_config.application_stack.dotnet_version, null)
        java_server         = try(var.settings.site_config.application_stack.java_server, null)
        java_server_version = try(var.settings.site_config.application_stack.java_server_version, null)
        java_version        = try(var.settings.site_config.application_stack.java_version, null)
        node_version        = try(var.settings.site_config.application_stack.node_version, null)
        php_version         = try(var.settings.site_config.application_stack.php_version, null)
        python_version      = try(var.settings.site_config.application_stack.python_version, null)
        ruby_version        = try(var.settings.site_config.application_stack.ruby_version, null)
      }
    }

    dynamic "auto_heal_setting" {
      for_each = lookup(var.settings.site_config, "auto_heal_setting", {}) == {} ? [] : [1]

      content {
        dynamic "action" {
          for_each = lookup(var.settings.site_config.auto_heal_setting, "action", {}) == {} ? [] : [1]

          content {
            action_type                    = var.settings.site_config.auto_heal_setting.action.action_type
            minimum_process_execution_time = try(var.settings.site_config.auto_heal_setting.action.minimum_process_execution_time, null)
          }
        }
        dynamic "trigger" {
          for_each = lookup(var.settings.site_config.auto_heal_setting, "trigger", {}) == {} ? [] : [1]

          content {
            dynamic "requests" {
              for_each = lookup(var.settings.site_config.auto_heal_setting.trigger, "requests", {}) == {} ? [] : [1]

              content {
                count    = var.settings.site_config.auto_heal_setting.trigger.requests.count
                interval = var.settings.site_config.auto_heal_setting.trigger.requests.interval
              }
            }
            dynamic "slow_request" {
              for_each = try(var.settings.site_config.auto_heal_setting.trigger.slow_requests, {})

              content {
                count      = slow_request.value.count
                interval   = slow_request.value.interval
                time_taken = slow_request.value.time_taken
                path       = try(slow_request.value.path, null)
              }
            }
            dynamic "status_code" {
              for_each = try(var.settings.site_config.auto_heal_setting.trigger.status_codes, {})

              content {
                count             = status_code.value.count
                interval          = status_code.value.interval
                status_code_range = status_code.value.status_code_range
                path              = try(status_code.value.path, null)
                sub_status        = try(status_code.value.sub_status, null)
              }
            }
          }
        }
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
