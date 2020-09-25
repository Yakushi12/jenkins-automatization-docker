#secret_manager
variable "secret_pair" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = map(string)
}
variable "project" {
  description = "The ID of the project"
  type        = string
}
