terraform {
  required_version = ">= 0.12.29"

  required_providers {
    google      = ">= 3.33.0"
    #google-beta = ">= 3.33.0"
  }

  backend "gcs" {
    bucket      = "dz-tf-backup"
    prefix      = "terraform/Dev"
    credentials = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
  }
}
