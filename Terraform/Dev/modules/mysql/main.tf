locals {
  ipv4_enabled = true
}

resource "google_sql_database_instance" "mysql" {
  name             = "dz-${var.mysql_name}"
  database_version = var.mysql_database_version
  region           = var.mysql_region

  settings {
    tier              = var.mysql_tier
    activation_policy = var.mysql_activation_policy
    ip_configuration {
      ipv4_enabled = local.ipv4_enabled

      dynamic "authorized_networks" {
        for_each = var.mysql_authorized_networks
        content {
          name  = lookup(authorized_networks.value, "name", null)
          value = lookup(authorized_networks.value, "value", null)
        }
      }
    }
  }
}

resource "google_sql_user" "root_user" {
  count    = 2
  name     = element(var.var.mysql_user_name, count.index)
  host     = var.mysql_user_host
  instance = google_sql_database_instance.mysql.name
  password = element(var.var.var.mysql_user_password, count.index)
}

resource "google_sql_database" "database" {
  name      = var.mysql_db_name
  project   = var.project
  charset   = var.mysql_charset
  instance  = google_sql_database_instance.mysql.name
  collation = var.mysql_collation
}

module "google_compute_instance_secret" {
  source = "../secret_manager"

  project = var.project
  secret_pair = {
    "mysql_ip_dz"         = google_sql_database_instance.mysql.public_ip_address
    "mysql_root_name"     = var.mysql_user_name
    "mysql_root_password" = var.mysql_user_password
  }
}
