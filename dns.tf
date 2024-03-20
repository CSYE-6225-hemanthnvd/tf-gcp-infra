resource "google_service_account" "logger_service_account" {
  account_id   = var.logger_service_account_id
  display_name = var.logger_service_account_name
}

resource "google_project_iam_binding" "loggingAdmin" {
  project = var.gcp_project
  role    = "roles/logging.admin"
  members = [
    "serviceAccount:${google_service_account.logger_service_account.email}",
  ]
}
resource "google_project_iam_binding" "metricWriter" {
  project = var.gcp_project
  role    = "roles/monitoring.metricWriter"
  members = [
    "serviceAccount:${google_service_account.logger_service_account.email}",
  ]
}
resource "google_dns_record_set" "a" {
  name         = var.dns_name
  managed_zone = var.dns_zone
  type         = var.dns_record_type
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_instance.app-instance.network_interface.0.access_config.0.nat_ip]
  depends_on   = [google_compute_instance.app-instance]
}