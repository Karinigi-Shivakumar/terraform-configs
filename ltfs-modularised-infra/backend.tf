terraform {
  backend "gcs" {
    bucket = "gcp-terraform-state-file-backup"
    prefix = "terraform/state"
  }
}

