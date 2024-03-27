resource "google_dns_record_set" "a" {
  name         = var.dns_name
  managed_zone = var.dns_zone
  type         = var.dns_record_type
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_instance.app-instance.network_interface.0.access_config.0.nat_ip]
  depends_on   = [google_compute_instance.app-instance]
}