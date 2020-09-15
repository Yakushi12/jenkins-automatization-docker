
#instance_group
variable "family" {
  description = ""
  type        = string
}
variable "project" {
  description = "The ID of the project"
  type        = string
}
variable "google_compute_name" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
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
variable "template_can_ip_forward" {
  description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false."
  default     = false
}
variable "template_scheduling_automatic_restart" {
  description = "The scheduling strategy to use."
  default     = true
}
variable "template_scheduling_on_host_maintenance" {
  description = "Defines the maintenance behavior for this instance."
  type        = string
  default     = "MIGRATE"
}
variable "template_network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
}
variable "template_subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in."
  type        = string
}
variable "template_service_account_scopes" {
  description = "A list of service scopes."
  type        = list
  default     = ["userinfo-email", "compute-ro", "storage-ro"]
}
variable "zone" {
  description = "Default project zone"
  type        = string
}
variable "google_compute_instance_image" {
  description = ""
  type        = string
}
variable "health_check_interval_sec" {
  description = "How often (in seconds) to send a health check. The default value is 5 seconds."
  type        = string
}
variable "backend_timeout_sec" {
  description = "How many seconds to wait for the backend before considering it a failed request. Default is 30 seconds. Valid range is [1, 86400]."
  type        = string
}
variable "health_check_name" {
  type = string
}
variable "health_check_port" {
  description = "The TCP port number for the HTTPS health check request. The default value is 443."
  type        = string
}
