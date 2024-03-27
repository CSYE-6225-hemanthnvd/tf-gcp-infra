resource "google_service_account" "vm_service_account" {
  account_id   = var.vm_service_account_id
  display_name = var.vm_service_account_name
}
resource "google_project_iam_binding" "loggingAdmin" {
  project    = var.gcp_project
  role       = "roles/logging.admin"
  depends_on = [google_service_account.vm_service_account]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}",
  ]
}
resource "google_project_iam_binding" "metricWriter" {
  project    = var.gcp_project
  role       = "roles/monitoring.metricWriter"
  depends_on = [google_service_account.vm_service_account]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}",
  ]
}
resource "google_pubsub_topic_iam_binding" "pubsub_publisher" {
  topic      = google_pubsub_topic.verify_email.name
  role       = "roles/pubsub.publisher"
  depends_on = [google_service_account.vm_service_account]
  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}",
  ]
}