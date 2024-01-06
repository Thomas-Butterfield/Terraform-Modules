locals {
  password_policy = try(var.ad_user.password_policy, var.password_policy)
  tenant_name     = lookup(var.ad_user, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  secret_prefix   = lookup(var.ad_user, "secret_prefix", "AAD-USER-")
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}

resource "azuread_user" "account" {
  user_principal_name         = try(var.ad_user.user_principal_name_full, null) != null ? var.ad_user.user_principal_name_full : format("%s@%s", var.ad_user.user_principal_name, local.tenant_name)
  display_name                = var.ad_user.display_name
  password                    = random_password.pwd.result
  account_enabled             = try(var.ad_user.account_enabled, true)
  business_phones             = try(var.ad_user.business_phones, null)
  city                        = try(var.ad_user.city, null)
  company_name                = try(var.ad_user.company_name, null)
  cost_center                 = try(var.ad_user.cost_center, null)
  country                     = try(var.ad_user.country, null)
  department                  = try(var.ad_user.department, null)
  disable_password_expiration = try(var.ad_user.disable_password_expiration, false)
  disable_strong_password     = try(var.ad_user.disable_strong_password, false)
  division                    = try(var.ad_user.division, null)
  employee_id                 = try(var.ad_user.employee_id, null)
  employee_type               = try(var.ad_user.employee_type, null)
  fax_number                  = try(var.ad_user.fax_number, null)
  force_password_change       = try(var.ad_user.force_password_change, false)
  given_name                  = try(var.ad_user.given_name, null)
  job_title                   = try(var.ad_user.job_title, null)
  mail                        = try(var.ad_user.mail, null)
  mail_nickname               = try(var.ad_user.mail_nickname, null)
  manager_id                  = try(var.ad_user.manager_id, null)
  mobile_phone                = try(var.ad_user.mobile_phone, null)
  office_location             = try(var.ad_user.office_location, null)
  onpremises_immutable_id     = try(var.ad_user.onpremises_immutable_id, null)
  other_mails                 = try(var.ad_user.other_mails, null)
  postal_code                 = try(var.ad_user.postal_code, null)
  preferred_language          = try(var.ad_user.preferred_language, null)
  show_in_address_list        = try(var.ad_user.show_in_address_list, true)
  state                       = try(var.ad_user.state, null)
  street_address              = try(var.ad_user.street_address, null)
  surname                     = try(var.ad_user.surname, null)
  usage_location              = try(var.ad_user.usage_location, null)

  # lifecycle {
  #   ignore_changes = [user_principal_name]
  # }
}

resource "time_rotating" "pwd" {
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}

# Will force the password to change every month
resource "random_password" "pwd" {
  keepers = {
    frequency = time_rotating.pwd.id
  }
  length  = local.password_policy.length
  special = local.password_policy.special
  upper   = local.password_policy.upper
  numeric = local.password_policy.numeric
}

resource "azurerm_key_vault_secret" "aad_user_name" {
  name         = format("%s%s-name", local.secret_prefix, var.ad_user.user_principal_name)
  value        = azuread_user.account.user_principal_name
  key_vault_id = var.key_vaults[var.ad_user.keyvault_key].id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  name            = format("%s%s-password", local.secret_prefix, var.ad_user.user_principal_name)
  value           = random_password.pwd.result
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
  key_vault_id    = var.key_vaults[var.ad_user.keyvault_key].id
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azuread_user.account
  ]

  create_duration = "30s"
}
