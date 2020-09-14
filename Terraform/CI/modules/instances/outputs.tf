output "instance_network_ip" {
  value = google_compute_instance.centos7.*.network_interface.0.network_ip
}
output "instance_nat_ip" {
  value = google_compute_instance.centos7.*.network_interface.0.access_config.0.nat_ip
}
output "instance_self_link" {
  value = google_compute_instance.centos7.*.self_link
}
output "instance_id" {
  value = google_compute_instance.centos7.*.id
}
