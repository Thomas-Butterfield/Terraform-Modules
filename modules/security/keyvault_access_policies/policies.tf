module "object_id" {
  source = "./access_policy"
  count  = try(var.access_policies.object_id, null) != null ? 1 : 0

  keyvault_id = coalesce(
    var.keyvault_id,
    try(var.keyvaults[var.access_policies.keyvault_key].id, null)
  )

  access_policy = var.access_policies
  tenant_id     = var.tenant_id
  object_id     = var.access_policies.object_id == "SUBSCRIPTION_ID" ? var.subscription_id : var.access_policies.object_id
}

module "managed_identity" {
  source = "./access_policy"
  count  = try(var.access_policies.managed_identity_key, null) != null ? 1 : 0

  keyvault_id = coalesce(
    var.keyvault_id,
    try(var.keyvaults[var.access_policies.keyvault_key].id, null)
  )

  access_policy = var.access_policies
  tenant_id     = var.tenant_id
  object_id     = try(var.managed_identities[var.access_policies.managed_identity_key].principal_id, null)
}
