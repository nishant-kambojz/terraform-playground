output "public_ip" {
  value = aws_instance.main.public_ip
}

output "private_ip" {
  value = aws_instance.main.private_ip
}

output "private_dns" {
  value = aws_instance.main.private_dns
}

output "public_dns" {
  value = aws_instance.main.public_dns
}

output "server_id" {
  value = aws_instance.main.id
}
