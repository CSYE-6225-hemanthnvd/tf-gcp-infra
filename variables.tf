variable "gcp_credentials" {
  type = string
}
variable "gcp_project" {
  type = string
}
variable "gcp_region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_routing_mode" {
  type = string
}
variable "subnetwork1_name" {
  type = string
}
variable "subnetwork1_ip_cidr_range" {
  type = string
}
variable "subnetwork2_name" {
  type = string
}
variable "subnetwork2_ip_cidr_range" {
}
variable "default_route_name" {
  type = string
}
variable "default_route_dest_range" {
  type = string
}
variable "next_hop_gateway" {
  type = string
}
variable "public_ingress_name" {
  type = string
}
variable "public_ingress_tag" {
  type = string
}
variable "public_ingress_source_range1" {
  type = string
}
variable "node_app_port" {
  type = string
}
variable "custom_image" {
  type = string
}
variable "compute_instance_name" {
  type = string
}
variable "compute_instance_machine" {
  type = string
}
variable "compute_instance_zone" {
  type = string
}
variable "compute_instance_size" {
  type = number
}
variable "compute_instance_disktype" {
  type = string
}
variable "access_config_network_tire" {
  type = string
}
