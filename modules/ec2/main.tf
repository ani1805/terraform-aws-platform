resource "aws_instance" "ec2_bastion" {
  ami = var.ami_id
  instance_type = var.ec2_instance_type
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name = var.key_pair_name
  user_data = file("${path.module}/scripts/bootstrap.sh")
  tags = {
    Name = "${var.environment}-ec2-bastion"
    Environment = var.environment
  }
  associate_public_ip_address = true
}