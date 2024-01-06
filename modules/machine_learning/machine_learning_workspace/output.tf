output "id" {
  description = "The ID of the Machine Learning Workspace"
  value       = azurerm_machine_learning_workspace.ws.id
}
output "name" {
  description = "The Name of the Machine Learning Workspace"
  value       = azurerm_machine_learning_workspace.ws.name
}
output "discovery_url" {
  description = "The url for the discovery service to identify regional endpoints for machine learning experimentation services"
  value       = azurerm_machine_learning_workspace.ws.discovery_url
}
