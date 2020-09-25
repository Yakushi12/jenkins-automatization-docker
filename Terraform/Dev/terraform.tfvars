#project
credentials_file = "account.json"
project          = "gd-gcp-internship-kha-koh"
region           = "us-central1"
zone             = "us-central1-c"

#instance_group
family                          = "petclinic-intern-website"
fw_target_tags                  = ["fw-tcp"]
template_network                = "intern-infra-net"
health_check_name               = "petclinic"
health_check_port               = "80"
google_compute_name             = "dz"
template_subnetwork             = "intern-infra-subnet"
template_machine_type           = "n1-standard-1"
health_check_interval_sec       = "30"
template_service_account_scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]

# LoadBalancer
lb_name                 = "petclinic-lb"
backend_timeout_sec     = "30"
backend_balancing_mode  = "UTILIZATION"
backend_capacity_scaler = "1.0"

#Database
#user
mysql_user_host = "%"
mysql_user_name = ["root", "petclinic"]
#db
mysql_name              = "petclinic-test-2"
mysql_tier              = "db-g1-small"
mysql_region            = "us-central1"
mysql_db_name           = "petclinic"
mysql_charset           = "utf8"
mysql_collation         = "utf8_general_ci"
mysql_database_version  = "MYSQL_5_7"
mysql_activation_policy = "ALWAYS"
mysql_authorized_networks = [{
  name  = "All"
  value = "0.0.0.0/0"
}]
