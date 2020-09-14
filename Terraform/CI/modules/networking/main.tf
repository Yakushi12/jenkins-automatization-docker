resource "google_compute_network" "vpc_network" {
  name        = "${var.networking_name}-net"
  description = var.vpc_description
  auto_create_subnetworks = false
  project = var.project
  routing_mode = var.routing_mode
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "${var.networking_name}-subnet"
  ip_cidr_range = var.ip_cidr_range #"10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = false
  # secondary_ip_range {
  #   range_name    = "tf-test-secondary-range-update1"
  #   ip_cidr_range = "192.168.10.0/24"
  # }
}

# resource "google_compute_address" "internal_with_subnet_and_address" {
#   name         = "my-internal-address"
#   subnetwork   = google_compute_subnetwork.vpc_subnetwork.id
#   address_type = "INTERNAL"
#   address      = "10.2.42.42"
#   region       = "us-central1"
# }

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
  target_tags = var.fw_target_tags
}
