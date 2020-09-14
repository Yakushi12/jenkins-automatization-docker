#project
variable "project" {
  description = "The ID of the project"
  type        = string
}
variable "routing_mode" {
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values are REGIONAL and GLOBAL."
  type    = string
  default = "REGIONAL"
}
variable "vpc_description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  type    = string
}
variable "region" {
  description = "Default project region"
  type        = string
}
variable "fw_ports" {
  type = list
}
variable "fw_target_tags" {
type = list
}
variable "networking_name" {
type = string
description = "Name of the resource"
}
variable "ip_cidr_range" {
type = string
}
