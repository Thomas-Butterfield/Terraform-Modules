
# Manages a password credential associated with an application within Azure Active Directory.
# These are also referred to as client secrets during authentication.

resource "azuread_application_password" "pwd" {

  application_object_id = coalesce(var.application_object_id, try(var.settings.application_object_id, null))
  display_name          = try(var.settings.display_name, null)
  end_date              = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
  end_date_relative     = try(var.settings.end_date_relative, null)
  start_date            = try(var.settings.start_date, null)
  rotate_when_changed = {
    rotation = time_rotating.pwd.id
  }

}

locals {
  password_policy = try(var.settings.password_policy, var.password_policy)
}

resource "time_rotating" "pwd" {
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [
    azuread_application_password.pwd
  ]

  create_duration = "30s"
}
