terraform {
  required_version = ">= 0.13"

  required_providers {
    github = {
      source  = "hashicorp/github"
      version = ">= 3.0.0"
    }
  }

  backend "gcs" {
    bucket      = "dz-tf-backup"
    prefix      = "terraform/GH"
    credentials = "../../../jenkins-automatization-docker-files/account.json"
  }
}
