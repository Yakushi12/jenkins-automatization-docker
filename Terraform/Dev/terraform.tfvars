#project
project = "gd-gcp-internship-kha-koh"
#credentials_file = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
credentials_file = "account.json"
region           = "us-central1"
zone             = "us-central1-c"
user             = "dzakharchenko"

#instance_group
family                          = "petclinic-intern-website"
fw_target_tags                  = ["fw-tcp"]
template_network                = "intern-infra-net" #"dzakharchenko-network"
health_check_name               = "petclinic"
google_compute_name             = "dz"
template_subnetwork             = "intern-infra-subnet" #"dzakharchenko-subnet"
template_machine_type           = "n1-standard-1"
template_startup_script         = "scripts/petclinic-nginx.sh"
google_compute_instance_image   = "projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-website"
template_service_account_scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
#google_compute_instance_image  = "projects/centos-cloud/global/images/family/centos-7"
#google_compute_image_family    = "centos-7"
#google_compute_image_project   = "centos-cloud"

# LoadBalancer
lb_name                   = "petclinic-lb"
health_check_port         = "80"
backend_timeout_sec       = "30"
backend_balancing_mode    = "UTILIZATION"
backend_capacity_scaler   = "1.0"
health_check_interval_sec = "30"

#Database
mysql_name              = "petclinic-test4"
mysql_tier              = "db-g1-small"
mysql_region            = "us-central1"
mysql_database_version  = "MYSQL_5_7"
mysql_activation_policy = "ALWAYS"
mysql_authorized_networks = [{
  name  = "All"
  value = "0.0.0.0/0"
}]
mysql_user_host     = "%"
mysql_user_name     = ["root", "petclinic"]
mysql_user_password = ["password", "petclinic"]
mysql_charset       = "utf8"
mysql_collation     = "utf8_general_ci"
mysql_db_name       = "petclinic"
