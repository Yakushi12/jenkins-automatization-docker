#GitHub
variable "owner" {
  description = "This is the target GitHub individual account to manage. It is optional to provide this value and it can also be sourced from the GITHUB_OWNER environment variable. For example, torvalds is a valid owner. When not provided and a token is available, the individual account owning the token will be used. When not provided and no token is available, the provider may not function correctly. Conflicts with organization."
  type        = string
}
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
variable "url" {
  description = "Payload URL. Webhook destination."
  type        = string
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
