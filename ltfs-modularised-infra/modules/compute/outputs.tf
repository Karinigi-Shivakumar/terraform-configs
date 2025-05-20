output "public_vm_external_ip" {
  description = "Public IP of the public VM"
  value       = google_compute_instance.public_vm.network_interface.0.access_config.0.nat_ip
}

output "private_vm_internal_ip" {
  description = "Internal IP of the private VM"
  value       = google_compute_instance.private_vm.network_interface.0.network_ip
}

