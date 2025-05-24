locals {
  ami_type                = "AL2_x86_64"
  azs                     = slice(data.aws_availability_zones.available.names, 0, 3)
  capacity_type           = "SPOT"
  cluster_name            = "microservice-course-project"
  cluster_version         = "1.32"
  disk_size               = 20
  enable_clustter_creator = true
  enable_nat_gateway      = true
  enable_public_access    = true
  instance_type           = ["t3.medium"]
  node_desirred_size      = 3
  node_max_size           = 5
  node_min_size           = 1
  intra_subnets           = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  private_subnets         = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  public_subnets          = ["10.0.30.0/24", "10.0.31.0/24", "10.0.32.0/24"]
  single_nat_gateway      = true
  vpc_cidr                = "10.0.0.0/16"
}
data "aws_availability_zones" "available" {}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "5.21.0"
  name               = "${local.cluster_name}-vpc" #microservice-course-project-vpc
  azs                = local.azs
  cidr               = local.vpc_cidr
  intra_subnets      = local.intra_subnets
  private_subnets    = local.private_subnets
  public_subnets     = local.public_subnets
  enable_nat_gateway = local.enable_nat_gateway
  single_nat_gateway = local.single_nat_gateway
}