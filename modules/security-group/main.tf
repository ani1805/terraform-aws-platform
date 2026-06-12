resource "aws_security_group" "sg_main" {
  name        = "${var.environment}-${var.component_name}-sg"
  vpc_id      = var.vpc_id
  description = "Security group for ${var.component_name}"
  tags = {
    Name        = "${var.environment}-${var.component_name}-sg"
    Environment = var.environment
  }
}