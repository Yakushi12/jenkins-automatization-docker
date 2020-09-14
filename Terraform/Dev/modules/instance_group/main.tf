# data "google_compute_image" "centos" {
#  family  = var.google_compute_image_family
#  project = var.google_compute_image_project
# }

#-------Create Template-------#
resource "google_compute_instance_template" "default" {
  name_prefix  = "${var.google_compute_name}-instance-"
  tags = var.fw_target_tags
  machine_type         = var.template_machine_type
  can_ip_forward       = var.template_can_ip_forward
  scheduling {
    automatic_restart   = var.template_scheduling_automatic_restart
    on_host_maintenance = var.template_scheduling_on_host_maintenance
  }
  disk {
    source_image = var.google_compute_instance_image
    #source_image = data.google_compute_image.centos.self_link
  }
  network_interface {
      network    = var.template_network
      subnetwork = var.template_subnetwork
      access_config { }
  }
  service_account {
      scopes = var.template_service_account_scopes
  }
  lifecycle {
      create_before_destroy = true
  }
}

#-------health check-------#
resource "google_compute_health_check" "default" {
  name   = "health-check-${var.health_check_name}"
  timeout_sec        = var.backend_timeout_sec
  check_interval_sec = var.health_check_interval_sec
  http_health_check {
    port             = var.health_check_port
    # port_specification = "USE_SERVING_PORT"
  }
}

#-------Create Instance Group Manager-------#
resource "google_compute_instance_group_manager" "instance_group_manager" {
  zone               = var.zone
  name               = "${var.google_compute_name}-scalable-petclinic"
  base_instance_name = "${var.google_compute_name}-pet"
  target_size        = "1"
  version {
    instance_template  = google_compute_instance_template.default.id
    name = "${var.google_compute_name}-centos7"
  }
  named_port {
    name = "http"
    port = "80"
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.default.id
    initial_delay_sec = 30
  }
}

#-------Create AutoScaler-------#
resource "google_compute_autoscaler" "dz-autoscaler" {
  name   = "${var.google_compute_name}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 30
    cpu_utilization {
      target = 0.75
    }
  }
}
