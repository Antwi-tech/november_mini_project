resource "aws_s3_bucket" "statefile_bucket" {
  bucket = "my-statefile-bucket"
  region = "us-east-1"

  tags = {
    Name        = "My statefile bucket"
    Environment = "dev"
  }
}

module "vpc" {
  source = "./vpc-module"

  vpc_cidr     = "10.0.0.0/16"
  subnet_cidr  = "10.0.1.0/24"
  az           = "us-east-1a"
}

module "ec2" {
  source = "./ec2-module"

  subnet_id      = module.vpc.subnet_id
  vpc_id         = module.vpc.vpc_id
  instance_type  = var.instance_type
  key_name       = var.key_name
}
