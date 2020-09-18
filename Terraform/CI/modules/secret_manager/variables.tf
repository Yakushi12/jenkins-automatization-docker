#secret_manager
variable "secret_pair" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND."
  type        = map(string)
  default = {
    "variable0" = "value0"
    "variable1" = "value1"
  }
}
variable "project" {
  description = "The ID of the project"
  type        = string
}
