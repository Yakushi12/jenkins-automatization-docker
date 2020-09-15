#project
project = "gd-gcp-internship-kha-koh"
#credentials_file = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
credentials_file = "account.json"
region           = "us-central1"
zone             = "us-central1-c"
user             = "dzakharchenko"

#bucket
bucket_state_name = "dzakharchenko_bucket"

#networking
networking_name = "intern-infra"
vpc_description = "network for jenkins and nexus"
routing_mode    = "REGIONAL"
ip_cidr_range   = "10.135.0.0/20"
fw_ports        = ["22", "80", "8080-8081"]
fw_target_tags  = ["fw-tcp"]

#instance_group
template_startup_script         = "scripts/petclinic-nginx.sh"
template_network                = "intern-infra-net"    #"dzakharchenko-network"
template_subnetwork             = "intern-infra-subnet" #"dzakharchenko-subnet"
template_machine_type           = "n1-standard-1"
template_service_account_scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
#google_compute_instance_image  = "projects/centos-cloud/global/images/family/centos-7"
#google_compute_image_family    = "centos-7"
#google_compute_image_project   = "centos-cloud"
google_compute_instance_image = "projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-website"
google_compute_name           = "dz"
health_check_name             = "petclinic"
family                        = "petclinic-intern-website"
# LoadBalancer
lb_name                   = "petclinic-lb"
backend_balancing_mode    = "UTILIZATION"
backend_capacity_scaler   = "1.0"
backend_timeout_sec       = "10"
health_check_interval_sec = "10"
health_check_port         = "80"

#Database
mysql_name              = "petclinic-test1"
mysql_database_version  = "MYSQL_5_7"
mysql_region            = "us-central1"
mysql_tier              = "db-g1-small"
mysql_activation_policy = "ALWAYS"
mysql_authorized_networks = [{
  name  = "All"
  value = "0.0.0.0/0"
}]
mysql_user_password = "petpass"
mysql_user_host     = "%"
mysql_user_name     = "root"
