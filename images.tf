
module "images" {
  source = "./modules/compute/image"
  for_each = {
    for key, value in try(local.settings.images, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings           = local.settings
  location                  = try(each.value.location, null)
  settings                  = each.value
  resource_group_name       = local.resource_groups[each.value.resource_group_key].name
  tags                      = try(each.value.tags, null)
  source_virtual_machine_id = local.virtual_machines[each.value.virtual_machine_key].id
}

module "images_reused" {
  source = "./modules/compute/image_reused"
  for_each = {
    for key, value in try(local.settings.images, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings = local.settings
  settings        = each.value
}

module "snapshots" {
  source = "./modules/compute/snapshot"
  for_each = {
    for key, value in try(local.settings.snapshots, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "shared_image_galleries" {
  source = "./modules/compute/shared_image_gallery/shared_image_gallery"
  for_each = {
    for key, value in try(local.settings.shared_image_galleries, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

module "shared_images" {
  depends_on = [
    module.shared_image_galleries
  ]
  source = "./modules/compute/shared_image_gallery/shared_image"
  for_each = {
    for key, value in try(local.settings.shared_images, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  gallery_name        = try(each.value.shared_image_gallery_key, null) != null ? module.shared_image_galleries[each.value.shared_image_gallery_key].name : try(each.value.gallery_name, null)
}

module "shared_image_versions" {
  depends_on = [
    module.shared_images,
    module.images,
    module.images_reused
  ]
  source = "./modules/compute/shared_image_gallery/shared_image_version"
  for_each = {
    for key, value in try(local.settings.shared_image_versions, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  location            = try(each.value.location, null)
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  gallery_name        = try(each.value.shared_image_gallery_key, null) != null ? module.shared_image_galleries[each.value.shared_image_gallery_key].name : try(each.value.gallery_name, null)
  image_name          = try(each.value.shared_image_key, null) != null ? module.shared_images[each.value.shared_image_key].name : try(each.value.image_name, null)
  managed_image_id    = try(each.value.image_key, null) != null ? local.images[each.value.image_key].id : try(each.value.virtual_machine_key, null) != null ? local.virtual_machines[each.value.virtual_machine_key].id : try(each.value.managed_image_id, null)
  storage_accounts    = module.storage_account
}
