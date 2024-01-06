module "configuration_keys" {
  source   = "./configuration_key"
  for_each = try(var.settings.configuration_keys, {})

  global_settings = var.global_settings
  settings        = each.value
}