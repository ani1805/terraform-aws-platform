resource "aws_db_instance" "name" {
  instance_class = var.rds_instance_class
  engine = "postgres"
  db_name = var.rds_db_name
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_grp.name
  vpc_security_group_ids = var.vpc_security_group_ids
  allocated_storage = var.allocated_storage
  identifier = "${var.environment}-rds-instance"
  username = var.username
  password = var.password
  skip_final_snapshot = true
  tags = {
    Name = "${var.environment}-rds-instance"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "rds_subnet_grp" {
  subnet_ids = var.subnet_ids
  
}