resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = true
}
resource "google_compute_subnetwork" "backend_subnet" {
  name          = var.subnetwork1_name
  ip_cidr_range = var.subnetwork1_ip_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_subnetwork" "proxy_only" {
  name          = var.subnetwork2_name
  ip_cidr_range = var.subnetwork2_ip_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
  purpose       = var.subnetwork2_purpose
  role          = var.subnetwork2_role
}
resource "google_compute_route" "default_route" {
  name             = var.default_route_name
  dest_range       = var.default_route_dest_range
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = var.next_hop_gateway
}
resource "google_compute_firewall" "allow_health_check" {
  name          = var.allow_health_check_firewall_name
  direction     = var.allow_health_check_firewall_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.allow_health_check_firewall_priority
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.firewall_target_tag]
  allow {
    protocol = "tcp"
    ports    = [var.node_app_port]
  }
}
resource "google_compute_firewall" "allow_proxy" {
  name = var.allow_proxy_firewall_name

  direction     = var.allow_proxy_firewall_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.allow_proxy_firewall_priority
  source_ranges = ["10.129.0.0/23"]
  target_tags   = [var.firewall_target_tag]
  allow {
    protocol = "tcp"
    ports    = [var.node_app_port]
  }
}
resource "google_compute_firewall" "deny_traffic" {
  name          = var.deny_traffic_firewall_name
  direction     = var.deny_traffic_firewall_direction
  network       = google_compute_network.vpc_network.id
  priority      = var.deny_traffic_firewall_priority
  source_ranges = [var.deny_traffic_firewall_source_range]
  target_tags   = [var.firewall_target_tag]
  deny {
    protocol = "tcp"
    ports    = [var.node_app_port]
  }
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}