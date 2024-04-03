resource "google_compute_region_autoscaler" "app_instance_group" {
  name   = var.autoscaler_name
  region = var.gcp_region
  target = google_compute_region_instance_group_manager.app_instance_group_manager.id
  autoscaling_policy {
    min_replicas    = var.autoscaler_min_replicas
    max_replicas    = var.autoscaler_max_replicas
    cooldown_period = var.autoscaler_cooldown_period
    cpu_utilization {
      target = var.autoscaler_cpu_utilization_target
    }
  }
}

resource "google_compute_region_instance_group_manager" "app_instance_group_manager" {
  name               = var.instance_group_manager_name
  base_instance_name = var.compute_instance_name
  region             = var.gcp_region
  version {
    name              = var.instance_group_manager_version_name
    instance_template = google_compute_region_instance_template.app_instance_template.self_link
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.healthz.id
    initial_delay_sec = var.instance_group_manager_auto_healing_policies_initial_delay
  }
  named_port {
    name = var.instance_group_manager_named_port_name
    port = var.instance_group_manager_named_port_port
  }
}