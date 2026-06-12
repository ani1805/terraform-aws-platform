module "vpc" {
  source                = "../../modules/vpc"
  vpc_cidr              = var.vpc_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zone_1   = var.availability_zone_1
  environment           = var.environment
  availability_zone_2   = var.availability_zone_2
}

module "ec2_bastion_security_group" {
  source         = "../../modules/security-group"
  vpc_id         = module.vpc.vpc_id
  environment    = var.environment
  component_name = "bastion"
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = module.ec2_bastion_security_group.security_group_id
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = [var.allowed_cidr_block_for_ssh]
}


module "rds_security_group" {
  source         = "../../modules/security-group"
  vpc_id         = module.vpc.vpc_id
  environment    = var.environment
  component_name = "rds"
}

module "ec2_bastion" {
  source            = "../../modules/ec2"
  environment       = var.environment
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.ec2_bastion_security_group.security_group_id
  ami_id            = var.ami_id
  ec2_instance_type = var.ec2_instance_type
  key_pair_name     = var.key_pair_name
}

module "rds_instance" {
  source                 = "../../modules/rds"
  environment            = var.environment
  subnet_ids             = [module.vpc.private_subnet_id_1, module.vpc.private_subnet_id_2]
  vpc_security_group_ids = [module.rds_security_group.security_group_id]
  allocated_storage      = var.rds_allocated_storage
  username               = var.rds_username
  rds_instance_class     = var.rds_instance_class
  rds_db_name            = var.rds_db_name
}