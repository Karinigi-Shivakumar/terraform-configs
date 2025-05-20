output "allow_app_server_rule" {
  description = "Firewall rule for allowing port 3804 to app server"
  value       = google_compute_firewall.allow_app_server.name
}

output "allow_kafka_rule" {
  description = "Firewall rule for Kafka traffic (9092)"
  value       = google_compute_firewall.allow_kafka.name
}

output "allow_internal_rule" {
  description = "Firewall rule for internal communication"
  value       = google_compute_firewall.allow_internal.name
}

output "allow_specific_ips_rule" {
  description = "Firewall rule for external IP access"
  value       = google_compute_firewall.allow_specific_ips.name
}

