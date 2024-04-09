resource "google_kms_key_ring" "webapp_keyring" {
  name     = var.webapp_keyring_name
  location = var.gcp_region
}
resource "google_kms_crypto_key" "vm_key" {
  name            = var.vm_key_name
  key_ring        = google_kms_key_ring.webapp_keyring.id
  rotation_period = var.key_rotation_period
}
resource "google_kms_crypto_key" "storage_bucket_key" {
  name            = var.storage_bucket_key_name
  key_ring        = google_kms_key_ring.webapp_keyring.id
  rotation_period = var.key_rotation_period
}
resource "google_kms_crypto_key" "sql_key" {
  name            = var.sql_key_name
  key_ring        = google_kms_key_ring.webapp_keyring.id
  rotation_period = var.key_rotation_period
}