
output "id" {
  description = "The Id of the Service Principal"
  value       = azuread_service_principal.sp.id
}
output "application_id" {
  description = "The Application Id of the Service Principal"
  value       = azuread_service_principal.sp.application_id
}
output "object_id" {
  description = "The Object Id of the Service Principal"
  value       = azuread_service_principal.sp.object_id
}
output "display_name" {
  description = "The display name of the application associated with this service principal"
  value       = azuread_service_principal.sp.object_id
}
output "oauth2_permission_scopes_ids" {
  description = "A mapping of OAuth2.0 permission scope values to scope IDs, as exposed by the associated application, intended to be useful when referencing permission scopes in other resources in your configuration"
  value       = azuread_service_principal.sp.oauth2_permission_scope_ids
}
output "oauth2_permission_scopes" {
  description = "A list of OAuth 2.0 delegated permission scopes exposed by the associated application"
  value       = azuread_service_principal.sp.oauth2_permission_scopes
}
output "rbac_id" {
  description = "The object ID of the service principal used for RBAC"
  value       = azuread_service_principal.sp.object_id
}
output "redirect_uris" {
  description = "A list of URLs where user tokens are sent for sign-in with the associated application, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent for the associated application"
  value       = azuread_service_principal.sp.redirect_uris
}
output "saml_metadata_url" {
  description = "The URL where the service exposes SAML metadata for federation"
  value       = azuread_service_principal.sp.saml_metadata_url
}
output "service_principal_names" {
  description = "A list of identifier URI(s), copied over from the associated application"
  value       = azuread_service_principal.sp.service_principal_names
}
output "sign_in_audience" {
  description = "The Microsoft account types that are supported for the associated application"
  value       = azuread_service_principal.sp.sign_in_audience
}
output "type" {
  description = "Identifies whether the service principal represents an application or a managed identity"
  value       = azuread_service_principal.sp.type
}
