# 1. Create Public VM (Has External IP)
resource "google_compute_instance" "public_vm" {
  name         = var.public_vm_name
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.public_subnet_id

    access_config { } # Assigns an external IP
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y apache2 wget unzip net-tools mysql-client openjdk-17-jdk
    sudo systemctl enable apache2
    sudo systemctl start apache2
  EOT
}

# 2. Create Private VM (No External IP)
resource "google_compute_instance" "private_vm" {
  name         = var.private_vm_name
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["kafka-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = var.private_subnet_id
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

