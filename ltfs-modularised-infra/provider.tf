provider "google" {
  credentials = file("~/primesquare-lab-6ba07215ec5b.json")
  project     = var.project_id
  region      = var.region
}

