terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
  name   = "security-group"
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  subnets_ids         = module.vpc.public_subnet_ids
  security_groups_ids = [module.security_group.security_group_id]
}

module "asg" {
  source                 = "./modules/autoscaling-group"
  name                   = "autoscaling-group"
  ami_id                 = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids             = module.vpc.public_subnet_ids
  target_group_arns      = [module.alb.target_group_arn]
}