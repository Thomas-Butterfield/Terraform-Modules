variable "global_settings" {
  description = "Global settings object"
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global_settings.location value."
  type        = string
  default     = null
}
variable "ml_compute_instance" {
  description = "Configuration settings object for the Machine Learning Compute Instance"
}
variable "machine_learning_workspace_id" {
  description = "Machine Learning Workspace ID"
  type        = string
}
variable "subnet_resource_id" {
  description = "Virtual network subnet resource ID the compute nodes belong to"
  type        = string
  default     = null
}
variable "managed_identities" {
  description = "Managed Identity module object"
  default     = {}
}
variable "ssh_keys" {
  description = "SSH Keys module object"
  default     = {}
}
variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default     = null
}
variable "client_config" {
  description = "Client configuration object from data.azurerm_client_config"
  default     = null
}
