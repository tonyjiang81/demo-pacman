module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "guru-vpc"

  cidr = "10.0.0.0/24"
  azs  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

  private_subnets = ["10.0.0.0/26", "10.0.0.64/26"]
  public_subnets  = ["1.0.0.128/26", "10.0.0.192/26"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
