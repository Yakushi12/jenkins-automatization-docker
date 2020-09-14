output "google_compute_global_address" {
  value       = google_compute_global_address.default.address
  description = "The IP of the created resource."
}
output "google_compute_backend_service" {
  value       = google_compute_backend_service.default.backend
  description = "The set of backends that serve this Backend Service."
}
output "google_compute_backend_id" {
  value       = google_compute_backend_service.default.id
  description = "an identifier for the resource with format projects/{{project}}/global/backendServices/{{name}}."
}
