variable "subscription_id" {
  description = "Azure Subscription ID for the current deployment."
  type        = string
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for the current deployment."
  type        = string
}

variable "hub_subscription_id" {
  description = "Azure Subscription ID for existing (data) Virtual Hubs for the current deployment. If none, use same value as var.subscription_id."
  type        = string
}

variable "sharedsvc_subscription_id" {
  description = "Azure Subscription ID for existing (data) Shared Svc Resources (LA Workspace) for the current deployment. If none or combined with CONNECT, use same value as var.hub_subscription_id."
  type        = string
}

variable "vm_admin_username" {
  description = "VM Admin Username (overriding settings.yaml) Provided by a DevOps Variable Group, KeyVault Secret or Clear Text Variable"
  type        = string
  default     = null
}

variable "vm_admin_password" {
  description = "VM Admin Password Provided by a DevOps Variable Group, KeyVault Secret or Clear Text Variable (not recommended)"
  type        = string
  default     = null
}

variable "vm_domain_username" {
  description = "VM Domain Username (overriding settings.yaml) Provided by a DevOps Variable Group, KeyVault Secret or Clear Text Variable"
  type        = string
  default     = null
}

variable "vm_domain_password" {
  description = "VM Domain User Password Provided by a DevOps Variable Group, KeyVault Secret or Clear Text Variable (not recommended)"
  type        = string
  default     = null
  sensitive   = true
}

variable "environment" {
  description = "Set environment for which settings.yaml to run"
  type        = string
  default     = null
}