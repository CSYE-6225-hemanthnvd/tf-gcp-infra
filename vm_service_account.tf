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
resource "google_project_iam_binding" "compute_engine_service_agent_iam_binding" {
  project = var.gcp_project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-858967335461@compute-system.iam.gserviceaccount.com",
  ]
}
resource "google_kms_crypto_key_iam_binding" "vm_key_iam_binding" {
  crypto_key_id = google_kms_crypto_key.vm_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-858967335461@compute-system.iam.gserviceaccount.com",
  ]
}