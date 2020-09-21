provider "github" {
  token = chomp(file(var.token))
}

data "github_repository" "test-repo" {
  full_name = var.repository_name
}

resource "github_repository_webhook" "foo" {
  repository = data.github_repository.test-repo.name
  active     = true
  events     = var.events

  configuration {
    url = "${var.protocol}${var.jenkins_ip}:${var.jenkins_port}/${var.request}"
    # var.url
    content_type = "json"
    insecure_ssl = true
  }
}
