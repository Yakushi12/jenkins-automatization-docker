#project
project          = "gd-gcp-internship-kha-koh"
#credentials_file = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
credentials_file = "~/.ssh/account.json"
region           = "us-central1"
zone             = "us-central1-c"
user             = "dzakharchenko"

#secret_manager
secret_pair = {
  "mysql_pass_dz"   = "petpass"
  #"service_acc_key" = file("/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json")
}

#networking
networking_name = "intern-infra"
vpc_description = "network for jenkins and nexus"
routing_mode    = "REGIONAL"
ip_cidr_range   = "10.135.0.0/20"
fw_ports        = ["22", "80", "8080-8081"]
fw_target_tags  = ["fw-tcp"]

#instances
instances_names = ["jenkins-petclinic-ci", "nexus-petclinic-ci"]
images          = ["projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-jenkins", "projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-nexus"]
#key_privat      = "/Users/dzakharchenko/.ssh/google_compute_engine.pub"
