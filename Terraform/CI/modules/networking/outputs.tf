# output "key_id" {
#   value       = google_service_account_key.mykey.id
#   description = "an identifier for the resource with format projects/{{project}}/serviceAccounts/{{account}}/keys/{{key}}"
# }
# output "public_key" {
#   value       = google_service_account_key.mykey.public_key
#   description = "The public key, base64 encoded"
# }
# output "private_key" {
#   value       = google_service_account_key.mykey.private_key
#   description = "The private key in JSON format, base64 encoded. This is what you normally get as a file when creating service account keys through the CLI or web console. This is only populated when creating a new key."
# }

output "fw_self_link" {
  value = google_compute_firewall.vpc_firewall.target_tags
}
output "subnet_self_link" {
  value = google_compute_subnetwork.vpc_subnetwork.self_link
}
output "net_self_link" {
  value = google_compute_network.vpc_network.self_link
}
