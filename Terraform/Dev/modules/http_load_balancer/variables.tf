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

variable "fw_network" {
  description = "The name or self_link of the network to attach this firewall to."
  type        = string
}

variable "google_compute_instance_group_manager" {
  type    = list
  default = []
}
variable "instance_group" {
  type = string
}

variable "google_compute_health_check" {

}
