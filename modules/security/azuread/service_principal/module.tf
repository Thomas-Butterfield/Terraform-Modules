
resource "azuread_service_principal" "sp" {
  account_enabled               = try(var.settings.account_enabled, true)
  alternative_names             = try(var.settings.alternative_names, null)
  app_role_assignment_required  = try(var.settings.app_role_assignment_required, false)
  application_id                = coalesce(var.application_id, try(var.settings.application_id, null))
  description                   = try(var.settings.description, null)
  login_url                     = try(var.settings.login_url, null)
  notes                         = try(var.settings.notes, null)
  notification_email_addresses  = try(var.settings.notification_email_addresses, null)
  owners                        = try(var.settings.owners, null)
  preferred_single_sign_on_mode = try(var.settings.preferred_single_sign_on_mode, null)
  tags                          = try(var.settings.tags, null)
  use_existing                  = try(var.settings.use_existing, null)

  #TODO
  # saml_single_sign_on

  # Cannot be used together with the tags property
  dynamic "feature_tags" {
    for_each = try(var.settings.feature_tags, {})

    content {
      custom_single_sign_on = try(feature_tags.value.custom_single_sign_on, null)
      enterprise            = try(feature_tags.value.enterprise, null)
      gallery               = try(feature_tags.value.gallery, null)
      hide                  = try(feature_tags.value.hide, null)
    }
  }
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azuread_service_principal.sp
  ]

  create_duration = "30s"
}
