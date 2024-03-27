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
variable "mysql_database_version" {
  type = string
}

variable "mysql_database_edition" {
  type = string
}
variable "mysql_database_availability_type" {
  type = string
}
variable "mysql_database_tier" {
  type = string
}
variable "mysql_database_disk_type" {
  type = string
}
variable "mysql_database_disk_size" {
  type = number
}
variable "database_name" {
  type = string
}
variable "sql_user" {
  type = string
}
variable "password_length" {
  type = number
}

variable "db_name_suffix_length" {
  type = number
}

variable "vm_service_account_id" {
  type = string
}
variable "vm_service_account_name" {
  type = string
}
variable "dns_name" {
  type = string
}
variable "dns_zone" {
  type = string
}
variable "dns_record_type" {
  type = string
}
variable "dns_record_ttl" {
  type = number
}
variable "MAILGUN_API_KEY" {
  type = string
}
variable "MAILGUN_DOMAIN" {
  type = string
}
variable "pubsub_topic_name" {
  type = string
}
variable "pubsub_subscription_name" {
  type = string
}
variable "pubsub_topic_message_retention_duration" {
  type = string
}
variable "cloudfunction_bucket_name" {
  type = string
}
variable "cloudfunction_bucket_location" {
  type = string
}

variable "cloudfunction_bucket_object_name" {
  type = string
}
variable "cloudfunction_name" {
  type = string
}
variable "cloudfunction_runtime" {
  type = string
}
variable "cloudfunction_entrypoint" {
  type = string
}

variable "cloudfunction_event_trigger_type" {
  type = string
}
variable "cloudfunction_event_trigger_retry_policy" {
  type = string
}
variable "vpc_connector_name" {
  type = string
}
variable "vpc_connector_cidr_range" {
  type = string
}
variable "vpc_connector_machine_type" {
  type = string
}