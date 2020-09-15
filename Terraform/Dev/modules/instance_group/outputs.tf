output "instance_group_manager_id" {
  value       = google_compute_instance_group_manager.instance_group_manager.id
  description = "an identifier for the resource with format projects/{{project}}/zones/{{zone}}/instanceGroupManagers/{{name}}"
}

output "instance_group_scope" {
  value       = google_compute_instance_group_manager.instance_group_manager.instance_group
  description = "The full URL of the instance group created by the manager."
}
output "google_compute_health_check" {
  value       = google_compute_health_check.default.self_link
}
