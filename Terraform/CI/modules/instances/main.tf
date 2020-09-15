resource "google_compute_instance" "centos7" {
  count        = 2
  name         = element(var.instances_names, count.index)
  machine_type = var.template_machine_type
  zone         = var.zone
  tags         = var.fw_target_tags
  boot_disk {
    initialize_params {
      image    = element(var.images, count.index)
    }
  }
  service_account {
    scopes     = var.template_service_account_scopes
  }
  network_interface {
    network    = var.template_network
    subnetwork = var.template_subnetwork
    access_config { }
  }
}

module "google_compute_instance_secret" {
  source = "../secret_manager"

  project = var.project
  secret_pair = {"nexus_ip_dz" = google_compute_instance.centos7.1.network_interface.0.access_config.0.nat_ip}
}
