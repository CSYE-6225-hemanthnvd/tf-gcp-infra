resource "random_id" "db_name_suffix" {
  byte_length = var.db_name_suffix_length
}
resource "random_password" "password" {
  length      = var.password_length
  special     = false
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}
resource "google_sql_user" "user" {
  instance   = google_sql_database_instance.main.name
  name       = var.sql_user
  password   = random_password.password.result
  depends_on = [google_sql_database_instance.main, random_password.password]
}
resource "google_sql_database" "database" {
  name       = var.database_name
  instance   = google_sql_database_instance.main.name
  depends_on = [google_sql_database_instance.main]
}
resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  provider = google-beta
  service  = "sqladmin.googleapis.com"
}
resource "google_kms_crypto_key_iam_binding" "sql_key_iam_binding" {
  crypto_key_id = google_kms_crypto_key.sql_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
  ]
}
resource "google_sql_database_instance" "main" {
  name                = "main-instance-${random_id.db_name_suffix.hex}"
  root_password       = random_password.password.result
  database_version    = var.mysql_database_version
  region              = var.gcp_region
  deletion_protection = false
  encryption_key_name = google_kms_crypto_key.sql_key.id
  depends_on          = [google_service_networking_connection.default, random_id.db_name_suffix, google_kms_crypto_key_iam_binding.sql_key_iam_binding]
  settings {
    edition           = var.mysql_database_edition
    availability_type = var.mysql_database_availability_type
    tier              = var.mysql_database_tier
    disk_type         = var.mysql_database_disk_type
    disk_size         = var.mysql_database_disk_size
    disk_autoresize   = false
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc_network.id
      enable_private_path_for_google_cloud_services = true
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
  }
}