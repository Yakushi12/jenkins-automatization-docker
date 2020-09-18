resource "google_secret_manager_secret" "secret" {
  project = var.project

  for_each  = var.secret_pair
  secret_id = each.key
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret-version" {
  for_each    = var.secret_pair
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value
}
