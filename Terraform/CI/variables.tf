#project
variable "credentials_file" {
  description = "Path to the service account key file in JSON format"
  type        = string
}
variable "project" {
  description = "The ID of the project"
  type        = string
}
variable "region" {
  description = "Default project region"
  type        = string
}
variable "zone" {
  description = "Default project zone"
  type        = string
}
variable "user" {
  description = "User"
  type        = string
}

#networking
variable "fw_ports" {
  type = list
}
variable "networking_name" {
  type = string
}
variable "ip_cidr_range" {
  type = string
}
variable "vpc_description" {
  type = string
}
variable "routing_mode" {
  type = string
}

#instances
variable "instances_names" {
  type    = list(string)
  default = ["jenkins-petclinic", "nexus-petclinic"]
}
variable "images" {
  type    = list(string)
  default = ["jenkins-centos7-1598453617", "nexus-centos7-1598457079"]
}
variable "template_service_account_scopes" {
  description = "A list of service scopes."
  type        = list
  default     = ["userinfo-email", "compute-ro", "storage-ro"]
}
variable "fw_target_tags" {
  description = "Tags to attach to the instance."
  type        = list
  default     = ["dz-fw-tcp"]
}
variable "template_machine_type" {
  description = "Tags to attach to the instance."
  type        = string
  default     = "g1-small"
}

#secret_manager
variable "secret_pair" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = map(string)
  default = {
    "variable0" = "value0"
    "variable1" = "value1"
  }
}
