
resource "azuread_application" "app" {

  display_name = var.settings.display_name

  owners = coalescelist(
    try(tolist(var.settings.owners), []),
    [
      var.client_config.object_id
    ]
  )

  #TODO
  # optional_claims block
  # public_client block
  # web block
  # single_page_application block

  device_only_auth_enabled       = try(var.settings.device_only_auth_enabled, null)
  fallback_public_client_enabled = try(var.settings.fallback_public_client_enabled, null)
  group_membership_claims        = try(var.settings.group_membership_claims, null)
  identifier_uris                = try(var.settings.identifier_uris, null)
  logo_image                     = try(var.settings.logo_image, null)
  marketing_url                  = try(var.settings.marketing_url, null)
  oauth2_post_response_required  = try(var.settings.oauth2_post_response_required, null)
  prevent_duplicate_names        = try(var.settings.prevent_duplicate_names, null)
  privacy_statement_url          = try(var.settings.privacy_statement_url, null)
  sign_in_audience               = try(var.settings.sign_in_audience, null)
  support_url                    = try(var.settings.support_url, null)
  template_id                    = try(var.settings.template_id, null)
  terms_of_service_url           = try(var.settings.terms_of_service_url, null)
  tags                           = try(var.settings.tags, null)

  # Documentation on resource_app_id values for Microsoft APIs can be difficult to find, but you can use the Azure CLI to find them. (e.g. az ad sp list --display-name "Microsoft Graph" --query '[].{appDisplayName:appDisplayName, appId:appId}')

  dynamic "required_resource_access" {
    for_each = try(var.azuread_api_permissions, {})

    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = {
          for key, resource in required_resource_access.value.resource_access : key => resource
        }

        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }

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

resource "azuread_service_principal" "app" {
  application_id                = azuread_application.app.application_id
  account_enabled               = try(var.settings.service_principal.account_enabled, true)
  alternative_names             = try(var.settings.service_principal.alternative_names, null)
  app_role_assignment_required  = try(var.settings.service_principal.app_role_assignment_required, false)
  description                   = try(var.settings.service_principal.description, null)
  login_url                     = try(var.settings.service_principal.login_url, null)
  notes                         = try(var.settings.service_principal.notes, null)
  notification_email_addresses  = try(var.settings.service_principal.notification_email_addresses, null)
  owners                        = try(var.settings.service_principal.owners, null)
  preferred_single_sign_on_mode = try(var.settings.service_principal.preferred_single_sign_on_mode, null)
  tags                          = try(var.settings.service_principal.tags, null)
  use_existing                  = try(var.settings.service_principal.use_existing, null)

  #TODO
  # saml_single_sign_on

  # Cannot be used together with the tags property
  dynamic "feature_tags" {
    for_each = try(var.settings.service_principal.feature_tags, {})

    content {
      custom_single_sign_on = try(feature_tags.value.custom_single_sign_on, null)
      enterprise            = try(feature_tags.value.enterprise, null)
      gallery               = try(feature_tags.value.gallery, null)
      hide                  = try(feature_tags.value.hide, null)
    }
  }
}

## NOTE: No reason at this time to auto-create an SPN password since app secret/cert should be used
##       We can create an SPN password using this referenced ID and configuring settings for service_principal_password

# resource "azuread_service_principal_password" "pwd" {

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azuread_application.app,
    azuread_service_principal.app
  ]

  create_duration = "30s"
}
