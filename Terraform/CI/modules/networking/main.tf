resource "google_compute_network" "vpc_network" {
  name                            = "${var.networking_name}-net"
  description                     = var.vpc_description
  project                         = var.project
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = "${var.networking_name}-subnet"
  ip_cidr_range            = var.ip_cidr_range #"10.2.0.0/16"
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = false
}

resource "google_compute_firewall" "vpc_firewall" {
  name    = "${var.networking_name}-fw"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = var.fw_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.fw_target_tags
}
