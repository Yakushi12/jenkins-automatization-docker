# resource "google_project_service" "secretmanager" {
#   service = "secretmanager.googleapis.com"
#   project = var.project
# }

resource "google_secret_manager_secret" "secret" {
  project = var.project

  for_each  = var.secret_pair
  secret_id = each.key
  replication {
    automatic = true
  }
  # depends_on = [google_project_service.secretmanager]
}

resource "google_secret_manager_secret_version" "secret-version" {
  for_each    = var.secret_pair
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value
}

# resource "google_secret_manager_secret_iam_member" "my-app" {
#   provider  = google-beta
#
#   secret_id = google_secret_manager_secret.my-secret.id
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "user:foo@bar.com" # or serviceAccount:my-app@...
# }
