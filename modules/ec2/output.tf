output "ec2_bastion_id" {
  value = aws_instance.ec2_bastion.id
}
output "ec2_bastion_public_ip_address" {
  value = aws_instance.ec2_bastion.public_ip
}