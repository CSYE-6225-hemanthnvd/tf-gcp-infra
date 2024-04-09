resource "google_cloudfunctions2_function" "send_email" {
  name       = var.cloudfunction_name
  location   = var.gcp_region
  depends_on = [google_storage_bucket.serverless_bucket, google_storage_bucket_object.serverless_bucket_object, google_vpc_access_connector.vpc-connector, google_sql_database.database, google_sql_database_instance.main, google_sql_user.user, random_password.password, google_pubsub_topic.verify_email, google_pubsub_subscription.verify_email_sub]
  build_config {
    runtime     = var.cloudfunction_runtime
    entry_point = var.cloudfunction_entrypoint
    source {
      storage_source {
        bucket = google_storage_bucket.serverless_bucket.name
        object = google_storage_bucket_object.serverless_bucket_object.name
      }
    }
  }
  service_config {
    vpc_connector = google_vpc_access_connector.vpc-connector.name
    environment_variables = {
      DATABASE        = google_sql_database.database.name
      HOST            = google_sql_database_instance.main.private_ip_address
      USER            = google_sql_user.user.name
      PASSWORD        = random_password.password.result
      MAILGUN_API_KEY = var.MAILGUN_API_KEY
      MAILGUN_DOMAIN  = var.MAILGUN_DOMAIN
    }
  }
  event_trigger {
    event_type   = var.cloudfunction_event_trigger_type
    pubsub_topic = google_pubsub_topic.verify_email.id
    retry_policy = var.cloudfunction_event_trigger_retry_policy
  }
}
resource "google_vpc_access_connector" "vpc-connector" {
  name          = var.vpc_connector_name
  ip_cidr_range = var.vpc_connector_cidr_range
  network       = google_compute_network.vpc_network.name
  machine_type  = var.vpc_connector_machine_type
}