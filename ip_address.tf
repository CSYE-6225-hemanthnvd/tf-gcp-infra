resource "google_compute_global_address" "webapp_ip" {
  name         = var.webapp_ip_name
  ip_version   = var.webapp_ip_version
  address_type = var.webapp_ip_address_type
}