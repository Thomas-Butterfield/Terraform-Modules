locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_queue"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_queue" "queue" {
  name                                    = module.resource_naming.name_result
  namespace_id                            = var.servicebus_namespace_id
  lock_duration                           = try(var.settings.lock_duration, "PT1M")
  max_message_size_in_kilobytes           = try(var.settings.max_message_size_in_kilobytes, null)
  max_size_in_megabytes                   = try(var.settings.max_size_in_megabytes, null)
  requires_duplicate_detection            = try(var.settings.requires_duplicate_detection, false)
  requires_session                        = try(var.settings.requires_session, false)
  default_message_ttl                     = try(var.settings.default_message_ttl, null)
  dead_lettering_on_message_expiration    = try(var.settings.dead_lettering_on_message_expiration, false)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, "PT10M")
  max_delivery_count                      = try(var.settings.max_delivery_count, 10)
  status                                  = try(var.settings.status, "Active")
  enable_batched_operations               = try(var.settings.enable_batched_operations, true)
  auto_delete_on_idle                     = try(var.settings.auto_delete_on_idle, null)
  enable_partitioning                     = try(var.settings.enable_partitioning, false)
  enable_express                          = try(var.settings.enable_express, null) # enable_express Defaults to false for Basic and Standard. For Premium, it MUST be set to false

  forward_to = try(coalesce(
    try(var.settings.forward_to.queue_name, null),
    try(var.settings.forward_to.topic_name, null),
    # try(var.servicebus_queues[var.settings.forward_to.queue_key].name, null),
    # try(var.servicebus_topics[var.settings.forward_to.topic_key].name, null),
  ), null)
  forward_dead_lettered_messages_to = try(coalesce(
    try(var.settings.forward_dead_lettered_messages_to.queue_name, null),
    try(var.settings.forward_dead_lettered_messages_to.topic_name, null),
    # try(var.servicebus_queues[var.settings.forward_dead_lettered_messages_to.queue_key].name, null),
    # try(var.servicebus_topics[var.settings.forward_dead_lettered_messages_to.topic_key].name, null),
  ), null)
}

module "queue_auth_rules" {
  source   = "./queue_auth_rule"
  for_each = try(var.settings.queue_auth_rules, {})

  global_settings     = var.global_settings
  settings            = each.value
  servicebus_queue_id = azurerm_servicebus_queue.queue.id
}
