resource "random_id" "db_name_suffix" {
  byte_length = var.db_name_suffix_length
}
resource "random_password" "password" {
  length      = var.password_length
  special     = true
  min_upper   = 2
  min_lower   = 2
  min_special = 2
  min_numeric = 2
}
resource "google_sql_user" "user" {
  instance = google_sql_database_instance.main.name
  name     = var.sql_user
  password = random_password.password.result
}
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.main.name
}
resource "google_sql_database_instance" "main" {
  name                = "main-instance-${random_id.db_name_suffix.hex}"
  root_password       = random_password.password.result
  database_version    = var.mysql_database_version
  region              = var.gcp_region
  deletion_protection = false
  depends_on          = [google_service_networking_connection.default]
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