
resource "azuread_service_principal_password" "pwd" {

  service_principal_id = var.service_principal_id
  display_name         = try(var.settings.display_name, null)
  end_date             = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
  end_date_relative    = try(var.settings.end_date_relative, null)
  start_date           = try(var.settings.start_date, null)
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
    azuread_service_principal_password.pwd
  ]

  create_duration = "30s"
}
