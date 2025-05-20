resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = var.private_subnet_name
  ip_cidr_range = var.private_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}


# 4. Reserve Static IP for Public VM
resource "google_compute_address" "public_ip" {
  name   = "public-vm-ip"
  region = var.region
}

# 5. Create Public VM with External IP
resource "google_compute_instance" "public_vm" {
  name         = var.public_vm_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"
  tags         = ["app-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config { # Enables External IP
      nat_ip = google_compute_address.public_ip.address
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y apache2 wget unzip net-tools mysql-client openjdk-17-jdk
    sudo systemctl enable apache2
    sudo systemctl start apache2
  EOT
}

# 6. Create Private VM (No External IP)
resource "google_compute_instance" "private_vm" {
  name         = var.private_vm_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"
  tags         = ["kafka-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.private_subnet.id
    access_config {} # No external IP assigned
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y unzip net-tools
    wget https://downloads.apache.org/kafka/3.5.1/kafka_2.13-3.5.1.tgz
    tar -xvzf kafka_2.13-3.5.1.tgz
    mv kafka_2.13-3.5.1 /opt/kafka
  EOT
}

# 7. Create a Cloud Router (Needed for NAT)
resource "google_compute_router" "router" {
  name    = "gcp-router"
  network = google_compute_network.vpc.id
  region  = var.region
}

# 8. Create a NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY" # Automatically allocates IPs
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["111.93.10.210/32", "202.65.158.18/32"] # Allow SSH from anywhere (Restrict if needed)
}

resource "google_compute_firewall" "allow_app" {
  name    = "allow-app-traffic"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["3804"]
  }

  source_ranges = ["111.93.10.210/32", "202.65.158.18/32"] # Allow access from anywhere (Restrict if needed)
  target_tags   = ["app-server"]
}

resource "google_compute_firewall" "allow_kafka" {
  name    = "allow-kafka-traffic"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["9092"]
  }

  source_ranges = ["10.0.0.0/16", "111.93.10.210/32", "202.65.158.18/32"] #m the VPC only (private)
  target_tags   = ["kafka-server"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal-communication"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/16", "111.93.10.210/32", "202.65.158.18/32"] # Allow full communication inside the VPC
}
