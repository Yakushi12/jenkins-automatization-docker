#project
project          = "gd-gcp-internship-kha-koh"
credentials_file = ""
region           = "us-central1"
zone             = "us-central1-c"

#networking
fw_ports        = ["22", "80", "8080-8081"]
routing_mode    = "REGIONAL"
ip_cidr_range   = "10.135.0.0/20"
fw_target_tags  = ["fw-tcp"]
networking_name = "intern-infra"
vpc_description = "network for jenkins and nexus"

#instances
images                          = ["projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-jenkins", "projects/gd-gcp-internship-kha-koh/global/images/family/petclinic-intern-nexus"]
instances_names                 = ["jenkins-petclinic-ci", "nexus-petclinic-ci"]
template_machine_type           = "e2-medium"
template_service_account_scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
