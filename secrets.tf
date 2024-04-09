resource "google_secret_manager_secret" "DATABASE_PRIVATE_IPV4" {
  secret_id = var.private_ip_address_secret_name
  replication {
    auto {}
  }
  depends_on = [google_sql_database_instance.main]
}
resource "google_secret_manager_secret_version" "DATABASE_PRIVATE_IPV4_VERSION" {
  secret      = google_secret_manager_secret.DATABASE_PRIVATE_IPV4.id
  secret_data = google_sql_database_instance.main.private_ip_address
  depends_on  = [google_sql_database_instance.main]
}
resource "google_secret_manager_secret" "DATABASE_PASSWORD" {
  secret_id = var.database_password_secret_name
  replication {
    auto {}
  }
  depends_on = [random_password.password]
}
resource "google_secret_manager_secret_version" "DATABASE_PASSWORD_VERSION" {
  secret      = google_secret_manager_secret.DATABASE_PASSWORD.id
  secret_data = random_password.password.result
  depends_on  = [random_password.password]
}
resource "google_secret_manager_secret" "DATABASE_USER" {
  secret_id = var.database_user_secret_name
  replication {
    auto {}
  }
  depends_on = [google_sql_user.user]
}
resource "google_secret_manager_secret_version" "DATABASE_USER_VERSION" {
  secret      = google_secret_manager_secret.DATABASE_USER.id
  secret_data = google_sql_user.user.name
  depends_on  = [google_sql_user.user]
}
resource "google_secret_manager_secret" "DATABASE_NAME" {
  secret_id = var.database_name_secret_name
  replication {
    auto {}
  }
  depends_on = [google_sql_database.database]
}
resource "google_secret_manager_secret_version" "DATABASE_NAME_VERSION" {
  secret      = google_secret_manager_secret.DATABASE_NAME.id
  secret_data = google_sql_database.database.name
  depends_on  = [google_sql_database.database]
}
resource "google_secret_manager_secret" "VM_KEY_ID" {
  secret_id = var.vm_key_id_secret_name
  replication {
    auto {}
  }
  depends_on = [google_kms_crypto_key.vm_key]
}
resource "google_secret_manager_secret_version" "VM_KEY_ID_VERSION" {
  secret      = google_secret_manager_secret.VM_KEY_ID.id
  secret_data = google_kms_crypto_key.vm_key.id
  depends_on  = [google_kms_crypto_key.vm_key]
}
resource "google_secret_manager_secret" "APP_INSTANCE_TEMPLATE_VERSION" {
  secret_id = var.app_instance_template_version_secret_name
  replication {
    auto {}
  }
}
resource "google_secret_manager_secret_version" "APP_INSTANCE_TEMPLATE_VERSION_VERSION" {
  secret      = google_secret_manager_secret.APP_INSTANCE_TEMPLATE_VERSION.id
  secret_data = var.app_instance_template_version_secret_data
}