output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "kafka_server_private_ip" {
  value = aws_instance.kafka_server.private_ip
}
