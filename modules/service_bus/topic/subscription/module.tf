locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_subscription"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_subscription" "subscription" {
  name                                      = module.resource_naming.name_result
  topic_id                                  = var.servicebus_topic_id
  max_delivery_count                        = var.settings.max_delivery_count
  auto_delete_on_idle                       = try(var.settings.auto_delete_on_idle, null)
  default_message_ttl                       = try(var.settings.default_message_ttl, null)
  lock_duration                             = try(var.settings.lock_duration, "PT1M")
  dead_lettering_on_message_expiration      = try(var.settings.dead_lettering_on_message_expiration, false)
  dead_lettering_on_filter_evaluation_error = try(var.settings.dead_lettering_on_filter_evaluation_error, true)
  enable_batched_operations                 = try(var.settings.enable_batched_operations, false)
  requires_session                          = try(var.settings.requires_session, false)
  status                                    = try(var.settings.status, "Active")
  client_scoped_subscription_enabled        = try(var.settings.client_scoped_subscription_enabled, false)

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

  dynamic "client_scoped_subscription" {
    for_each = try(var.settings.client_scoped_subscription, {}) == {} ? [] : [1]

    content {
      client_id                               = try(var.settings.client_scoped_subscription.client_id, null)
      is_client_scoped_subscription_shareable = try(var.settings.client_scoped_subscription.is_client_scoped_subscription_shareable, true)
      is_client_scoped_subscription_durable   = try(var.settings.client_scoped_subscription.is_client_scoped_subscription_durable, null)
    }
  }
}
