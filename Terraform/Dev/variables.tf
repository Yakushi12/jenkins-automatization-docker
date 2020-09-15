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

#instance_group
variable "google_compute_name" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
}
variable "fw_target_tags" {
  description = "Tags to attach to the instance."
  type        = list
  default     = ["dz-fw-tcp"]
}
variable "template_startup_script" {
  description = "An alternative to using the startup-script metadata key, mostly to match the compute_instance resource. This replaces the startup-script metadata key on the created instance and thus the two mechanisms are not allowed to be used simultaneously."
  type        = string
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
variable "template_lifecycle_create_before_destroy" {
  description = "By default, when Terraform must make a change to a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing object and then create a new replacement object with the new configured arguments."
  default     = true
}
variable "template_service_account_scopes" {
  description = "A list of service scopes."
  type        = list
  default     = ["userinfo-email", "compute-ro", "storage-ro"]
}
variable "google_compute_instance_image" {
  description = ""
  type        = string
}
variable "family" {
  description = ""
  type        = string
}

#mysql
variable "mysql_name" {
  description = "The name of the instance."
  type        = string
}
variable "mysql_database_version" {
  description = "Version of using database."
  type        = string
}
variable "mysql_region" {
  description = "The region the instance will sit in."
  type        = string
}
variable "mysql_tier" {
  description = "The machine type to use."
  type        = string
}
variable "mysql_activation_policy" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = string
}
variable "mysql_authorized_networks" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = list(map(string))
  default = [
    {
      name  = "All"
      value = "0.0.0.0/0"
    }
  ]
}
variable "mysql_user_password" {
  description = "The password for the user. Can be updated."
  type        = string
}
variable "mysql_user_host" {
  description = "The host the user can connect from."
  type        = string
  default     = "%"
}
variable "mysql_user_name" {
  description = "The name of mysql user."
  type        = string
}

#http_load_balancer
variable "lb_name" {
  description = "Name of the resource. Provided by the client when the resource is created."
  type        = string
}
variable "backend_balancing_mode" {
  description = "Specifies the balancing mode for this backend. For global HTTP(S) or TCP/SSL load balancing, the default is UTILIZATION. Valid values are UTILIZATION, RATE (for HTTP(S)) and CONNECTION (for TCP/SSL). Default value is UTILIZATION. Possible values are UTILIZATION, RATE, and CONNECTION."
  type        = string
}
variable "backend_capacity_scaler" {
  description = "A multiplier applied to the group's maximum servicing capacity (based on UTILIZATION, RATE or CONNECTION). Default value is 1, which means the group will serve up to 100% of its configured capacity (depending on balancingMode). A setting of 0 means the group is completely drained, offering 0% of its available Capacity. Valid range is [0.0,1.0]."
  type        = string
}
variable "backend_timeout_sec" {
  description = "How many seconds to wait for the backend before considering it a failed request. Default is 30 seconds. Valid range is [1, 86400]."
  type        = string
}
variable "health_check_name" {
  description = "Name of the resource. Provided by the client when the resource is created."
  type        = string
}
variable "health_check_interval_sec" {
  description = "How often (in seconds) to send a health check. The default value is 5 seconds."
  type        = string
}
variable "health_check_port" {
  description = "The TCP port number for the HTTPS health check request. The default value is 443."
  type        = string
}
