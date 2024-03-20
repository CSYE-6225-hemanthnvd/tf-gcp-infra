resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = true
}
resource "google_compute_subnetwork" "network1" {
  name          = var.subnetwork1_name
  ip_cidr_range = var.subnetwork1_ip_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_subnetwork" "network2" {
  name          = var.subnetwork2_name
  ip_cidr_range = var.subnetwork2_ip_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}
resource "google_compute_route" "default_route" {
  name             = var.default_route_name
  dest_range       = var.default_route_dest_range
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = var.next_hop_gateway
}
resource "google_compute_firewall" "public_ingress" {
  name          = var.public_ingress_name
  network       = google_compute_network.vpc_network.name
  target_tags   = [var.public_ingress_tag]
  source_ranges = [var.public_ingress_source_range1]
  allow {
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