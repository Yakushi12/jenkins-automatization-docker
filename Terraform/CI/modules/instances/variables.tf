variable "instances_names" {
  type    = list(string)
  default = ["jenkins-petclinic", "nexus-petclinic"]
}
variable "images" {
  type    = list(string)
  default = ["jenkins-centos7-1598453617", "nexus-centos7-1598457079"]
}
variable "template_machine_type" {
  description = "Tags to attach to the instance."
  type        = string
  default     = "g1-small"
}
variable "zone" {
  description = "Default project zone"
  type        = string
}
variable "fw_target_tags" {
  description = "Tags to attach to the instance."
  type        = list
  #  default     = ["dz-fw-tcp"]
}
variable "template_network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
}
variable "template_subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in."
  type        = string
}
variable "project" {
  description = "The ID of the project"
  type        = string
}
variable "template_service_account_scopes" {
  description = "A list of service scopes."
  type        = list
  default     = ["userinfo-email", "compute-ro", "storage-ro"]
}
