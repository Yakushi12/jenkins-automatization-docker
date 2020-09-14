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
  type = list(map(string))
  default = [
    {
      name = "All"
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
variable "project" {
  description = "The ID of the project"
  type        = string
}
