terraform {
  backend "gcs" {
    bucket = "gcp-terraform-statefile-backup"
    prefix = "terraform/state"
  }
}

