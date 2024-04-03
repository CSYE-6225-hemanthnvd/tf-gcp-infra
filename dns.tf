resource "google_dns_record_set" "a" {
  name         = var.dns_name
  managed_zone = var.dns_zone
  type         = var.dns_record_type
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_global_address.webapp_ip.address]
  depends_on   = [google_compute_global_address.webapp_ip]
}