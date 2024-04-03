resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = var.global_forwarding_rule_name
  ip_protocol           = var.global_forwarding_rule_ip_protocol
  load_balancing_scheme = var.load_balancing_scheme
  port_range            = var.global_forwarding_rule_port_range
  target                = google_compute_target_https_proxy.target_https_proxy.id
  ip_address            = google_compute_global_address.webapp_ip.id
  depends_on            = [google_compute_subnetwork.proxy_only]
}
resource "google_compute_managed_ssl_certificate" "ssl_certificate" {
  name = var.ssl_certificate_name
  managed {
    domains = [var.domain]
  }
}
resource "google_compute_target_https_proxy" "target_https_proxy" {
  name             = var.target_https_proxy_name
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_certificate.id]
}
resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.default.id
}
resource "google_compute_backend_service" "default" {
  name                  = var.backend_service_name
  protocol              = var.backend_service_protocol
  port_name             = var.instance_group_manager_named_port_name
  load_balancing_scheme = var.load_balancing_scheme
  health_checks         = [google_compute_health_check.healthz.id]
  backend {
    balancing_mode  = var.backend_service_balancing_mode
    group           = google_compute_region_instance_group_manager.app_instance_group_manager.instance_group
    capacity_scaler = var.backend_service_capacity_scaler
  }
}