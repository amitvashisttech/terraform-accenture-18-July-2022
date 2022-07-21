output "Public_IPs" { 
  value = aws_instance.instance.*.public_ip 
}
