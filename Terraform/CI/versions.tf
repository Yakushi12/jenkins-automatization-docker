terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.38.0"
    }
  }

  backend "gcs" {
    bucket      = "dz-tf-backup"
    prefix      = "terraform/CI"
    credentials = "/Users/dzakharchenko/WhoAmI/gcp/service_acc_key.json"
  }
}
