
output "application_id" {
  description = "The Application Id of the Application"
  value       = azuread_application.app.application_id
}

output "client_id" {
  description = "The Client Id of the Application"
  value       = azuread_application.app.application_id
}

output "object_id" {
  description = "The Object Id of the Application"
  value       = azuread_application.app.object_id
}

output "tenant_id" {
  description = "The tenand_id of the Azure AD Group"
  value       = var.client_config.tenant_id
}

output "app_role_ids" {
  description = "A mapping of app role values to app role IDs, intended to be useful when referencing app roles in other resources in your configuration"
  value       = azuread_application.app.app_role_ids
}

output "disabled_by_microsoft" {
  description = "Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. DisabledDueToViolationOfServicesAgreement"
  value       = azuread_application.app.disabled_by_microsoft
}

output "logo_url" {
  description = "CDN URL to the application's logo, as uploaded with the logo_image property"
  value       = azuread_application.app.logo_url
}

output "oauth2_permission_scope_ids" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs, intended to be useful when referencing permission scopes in other resources in your configuration"
  value       = azuread_application.app.oauth2_permission_scope_ids
}

output "publisher_domain" {
  description = "The verified publisher domain for the application"
  value       = azuread_application.app.publisher_domain
}

output "azuread_application" {
  description = "Application object output"
  value = {
    id             = azuread_application.app.id
    object_id      = azuread_application.app.object_id
    application_id = azuread_application.app.application_id
  }

}

output "azuread_service_principal" {
  description = "This attribute is used to set the role assignment for an application"
  value = {
    id        = azuread_service_principal.app.id
    object_id = azuread_service_principal.app.object_id
  }
}

output "rbac_id" {
  description = "This attribute is used to set the role assignment for an application"
  value       = azuread_service_principal.app.object_id
}
