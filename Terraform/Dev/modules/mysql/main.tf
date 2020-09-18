provider "mysql" {
  endpoint = local.mysql_connection
  username = google_sql_user.root_user.name
  password = google_sql_user.root_user.password
}

locals {
  ipv4_enabled     = true
  mysql_connection = "${google_sql_database_instance.mysql.public_ip_address}:3306"
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

resource "random_password" "mysql_root_password" {
  count            = 2
  length           = 5
  special          = true
  override_special = "_!"
}

resource "google_sql_user" "root_user" {
  depends_on = [random_password.mysql_root_password[0]]
  # count      = 1
  # name       = element(var.mysql_user_name, count.index)
  name     = var.mysql_user_name[0]
  host     = var.mysql_user_host
  instance = google_sql_database_instance.mysql.name
  password = random_password.mysql_root_password[0].result #element(var.mysql_user_password, count.index)
}

# resource "google_sql_database" "database" {
#   name      = var.mysql_db_name
#   project   = var.project
#   charset   = var.mysql_charset
#   instance  = google_sql_database_instance.mysql.name
#   collation = var.mysql_collation
# }

resource "mysql_database" "petclinic" {
  name                  = var.mysql_db_name
  default_character_set = var.mysql_charset
  default_collation     = var.mysql_collation
}

resource "mysql_user" "petclinic" {
  user               = var.mysql_user_name[1]
  host               = var.mysql_user_host
  plaintext_password = random_password.mysql_root_password[1].result
}

resource "mysql_grant" "petclinic" {
  user       = mysql_user.petclinic.user
  host       = mysql_user.petclinic.host
  database   = mysql_database.petclinic.name
  privileges = ["ALL"]
}

module "google_compute_instance_secret" {
  source = "../secret_manager"

  project = var.project
  secret_pair = {
    "mysql_ip_dz"         = google_sql_database_instance.mysql.public_ip_address
    "mysql_root_name"     = google_sql_user.root_user.name          #var.mysql_user_name[0]
    "mysql_root_password" = google_sql_user.root_user.password      #var.mysql_user_password[0]
    "mysql_user_name"     = mysql_user.petclinic.user               #var.mysql_user_name[1]
    "mysql_user_password" = mysql_user.petclinic.plaintext_password #| base64 --decode | keybase pgp decrypt #var.mysql_user_password[1]
  }
}
