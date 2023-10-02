terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workload = "blackoak"
}

module "vpc" {
  source     = "./modules/vpc"
  aws_region = var.aws_region
  workload   = local.workload
}

module "rds_mysql" {
  source         = "./modules/mysql"
  workload       = local.workload
  vpc_id         = module.vpc.vpc_id
  subnets        = module.vpc.private_subnets
  multi_az       = var.rds_multi_az
  instance_class = var.rds_instance_class
  username       = var.rds_username
  password       = var.rds_password
}

module "jumpserver" {
  source    = "./modules/jumpserver"
  workload  = local.workload
  vpc_id    = module.vpc.vpc_id
  az        = module.vpc.azs[0]
  subnet    = module.vpc.public_subnets[0]
  allow_ssh = var.jumpserver_allow_ssh
}
