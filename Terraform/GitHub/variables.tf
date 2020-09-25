#GitHub
variable "token" {
  description = "A GitHub OAuth / Personal Access Token. When not provided or made available via the GITHUB_TOKEN environment variable, the provider can only access resources available anonymously."
  type        = string
}
variable "repository_name" {
  description = "Full name of the repository (in org/name format)."
  type        = string
}
variable "events" {
  description = "A list of events which should trigger the webhook."
  type        = list(string)
}
variable "protocol" {
  description = "The protocol."
  type        = string
}
variable "jenkins_ip" {
  description = "Instance IP with Jenkins."
  type        = string
}
variable "jenkins_port" {
  description = "Port where application is listening."
  type        = string
}
variable "request" {
  description = "Request that provide remote event execution."
  type        = string
}
