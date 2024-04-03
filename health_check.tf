resource "google_compute_health_check" "healthz" {
  name                = var.health_check_name
  check_interval_sec  = var.health_check_check_interval_sec
  timeout_sec         = var.health_check_timeout_sec
  healthy_threshold   = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold

  http_health_check {
    request_path = var.http_health_check_request_path
    port         = var.node_app_port
  }
}