module "configuration_features" {
  source   = "./configuration_feature"
  for_each = try(var.settings.configuration_features, {})

  global_settings = var.global_settings
  settings        = each.valueze
}