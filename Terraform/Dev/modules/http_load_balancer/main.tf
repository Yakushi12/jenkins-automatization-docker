locals {
global_address_name = "http"
}

resource "google_compute_global_address" "default" {
  name         = local.global_address_name
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

#-------forward traffic to the correct load balancer-------#
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "front-${var.lb_name}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  ip_address            = google_compute_global_address.default.address
  target                = google_compute_target_http_proxy.default.id
}

#-------target proxy-------#
resource "google_compute_target_http_proxy" "default" {
  name    = "proxy-${var.lb_name}"
  url_map = google_compute_url_map.default.self_link
}

# -------url map-------#
resource "google_compute_url_map" "default" {
  name            = "urlmap-${var.lb_name}"
  default_service = google_compute_backend_service.default.self_link
}

#-------backend service -------#
#-------defines a group of virtual machines that will serve traffic for load balancing-------#
resource "google_compute_backend_service" "default" {
  load_balancing_scheme = "EXTERNAL"
  backend {
    group           = var.instance_group
    balancing_mode  = var.backend_balancing_mode
    capacity_scaler = var.backend_capacity_scaler
  }
    name          = "backend-${var.lb_name}"
    port_name     = local.global_address_name
    protocol      = "HTTP"
    timeout_sec   = var.backend_timeout_sec
    health_checks = [var.google_compute_health_check]
    depends_on    = [var.google_compute_instance_group_manager]
}

resource "google_compute_firewall" "default" {
  name    = "firewall-${var.lb_name}"
  network = var.fw_network
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22"]
  target_tags   = [local.global_address_name]
}
