data "google_storage_project_service_account" "gcs_account" {
}
resource "google_kms_crypto_key_iam_binding" "bucket_iam_binding" {
  crypto_key_id = google_kms_crypto_key.storage_bucket_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}
resource "google_storage_bucket" "serverless_bucket" {
  name                        = var.cloudfunction_bucket_name
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  depends_on                  = [google_kms_crypto_key_iam_binding.bucket_iam_binding]
  encryption {
    default_kms_key_name = google_kms_crypto_key.storage_bucket_key.id
  }
}
resource "google_storage_bucket_object" "serverless_bucket_object" {
  name   = var.cloudfunction_bucket_object_name
  bucket = google_storage_bucket.serverless_bucket.name
  source = var.cloudfunction_bucket_object_name
}