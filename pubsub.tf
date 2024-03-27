resource "google_pubsub_topic" "verify_email" {
  name                       = var.pubsub_topic_name
  message_retention_duration = var.pubsub_topic_message_retention_duration
}


resource "google_pubsub_subscription" "verify_email_sub" {
  name  = var.pubsub_subscription_name
  topic = google_pubsub_topic.verify_email.id
}


