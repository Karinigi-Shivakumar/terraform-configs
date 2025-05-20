# Allow traffic on port 3804 for app-server
resource "google_compute_firewall" "allow_app_server" {
  name    = "allow-app-server-traffic"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["3804"]
  }

  source_ranges = ["111.93.10.210/32", "202.65.158.18/32"] # Restrict to required IPs
  target_tags   = ["app-server"]
}

# Allow Kafka traffic (9092) for internal communication + specific public IPs
resource "google_compute_firewall" "allow_kafka" {
  name    = "allow-kafka-traffic"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["9092"]
  }

  source_ranges = ["10.0.0.0/16"] # Internal only
  target_tags   = ["kafka-server"]
}

# Allow full internal communication within the VPC
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal-communication"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/16"] # Internal only
}

# Allow access from specific external IPs to the internal network (if needed)
resource "google_compute_firewall" "allow_specific_ips" {
  name    = "allow-specific-external-ips"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "3804", "9092"] # Adjust as needed
  }

  source_ranges = ["111.93.10.210/32", "202.65.158.18/32"]
}
