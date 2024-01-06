variable "global_settings" {
  description = "Global settings object"
}
variable "settings" {
  description = "Configuration settings object for the resource"
}
variable "subscription_primary" {
  description = "Primary Subscription ID used for default assigned scope"
  type        = string
}
variable "assignable_scopes" {
  description = "One or more assignable scopes for this Role Definition, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM"
  default     = []
}
