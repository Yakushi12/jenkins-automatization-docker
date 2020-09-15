terraform {
  required_version = ">= 0.13"

  required_providers {
    google = ">= 3.38.0"
    #google-beta = ">= 3.33.0"
  }

  backend "gcs" {
    bucket      = "dz-tf-backup"
    prefix      = "terraform/CI"
    credentials = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
  }
}
