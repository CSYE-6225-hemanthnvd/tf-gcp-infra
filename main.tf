resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = false
  routing_mode = var.vpc_routing_mode
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
resource "google_compute_route" "default" {
  name = var.default_route_name
  dest_range  = var.default_route_dest_range
  network     = google_compute_network.vpc_network.id
  next_hop_gateway = "default-internet-gateway"
}