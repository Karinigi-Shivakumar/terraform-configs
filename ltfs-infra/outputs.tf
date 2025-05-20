output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "public_subnet" {
  value = google_compute_subnetwork.public_subnet.id
}

output "private_subnet" {
  value = google_compute_subnetwork.private_subnet.id
}
output "vpc_id" {
  description = "ID of the created VPC"
  value       = google_compute_network.vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = google_compute_subnetwork.public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = google_compute_subnetwork.private_subnet.id
}

output "public_vm_external_ip" {
  description = "Public IP of the public VM"
  value       = google_compute_instance.public_vm.network_interface.0.access_config.0.nat_ip
}

output "private_vm_internal_ip" {
  description = "Internal IP of the private VM"
  value       = google_compute_instance.private_vm.network_interface.0.network_ip
}

