output "fw_self_link" {
  value = google_compute_firewall.vpc_firewall.target_tags
}
output "subnet_self_link" {
  value = google_compute_subnetwork.vpc_subnetwork.self_link
}
output "net_self_link" {
  value = google_compute_network.vpc_network.self_link
}
