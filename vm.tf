resource "google_compute_instance" "app-instance" {
  name         = var.compute_instance_name
  machine_type = var.compute_instance_machine
  zone         = var.compute_instance_zone
  tags         = [var.public_ingress_tag]
  depends_on   = [google_sql_database_instance.main, google_service_account.vm_service_account, google_project_iam_binding.loggingAdmin, google_project_iam_binding.metricWriter, google_pubsub_topic_iam_binding.pubsub_publisher]
  boot_disk {
    initialize_params {
      image = var.custom_image
      size  = var.compute_instance_size
      type  = var.compute_instance_disktype
    }
  }
  metadata = {
    db_name         = google_sql_database.database.name
    db_private_ipv4 = google_sql_database_instance.main.private_ip_address
    db_user         = google_sql_user.user.name
    db_password     = random_password.password.result
  }
  metadata_startup_script = <<-EOT
    #!/bin/bash
    chmod -R 777 /var/www/webapp
    if ! test -f /var/www/webapp/.env; then
      DATABASE=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_name" -H "Metadata-Flavor: Google")
      USER=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_user" -H "Metadata-Flavor: Google")
      PASSWORD=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_password" -H "Metadata-Flavor: Google")
      HOST=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/db_private_ipv4" -H "Metadata-Flavor: Google")
      sudo echo "DATABASE=$DATABASE" >> /var/www/webapp/.env
      sudo echo "USER=$USER" >> /var/www/webapp/.env
      sudo echo "PASSWORD=$PASSWORD" >> /var/www/webapp/.env
      sudo echo "HOST=$HOST" >> /var/www/webapp/.env
      sudo chown csye6225 /var/www/webapp/.env
      sudo chgrp csye6225 /var/www/webapp/.env
      chmod -R 755 /var/www/webapp
    fi
    EOT
  network_interface {
    access_config {
      network_tier = var.access_config_network_tire
    }
    queue_count = 0
    subnetwork  = google_compute_subnetwork.network1.name
  }
  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }
}