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