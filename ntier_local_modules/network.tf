module "vpc" {
  source = "./modules/vpc"
  vpc_info = {
    cidr_block           = "192.168.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "Simple-vpc"
    }
  }
  public_subnets = [{
    cidr_block = "192.168.0.0/24"
    az         = "us-east-2a"
    tags = {
      Name = "public"
    }

  }]
  private_subnets = [{
    cidr_block = "192.168.1.0/24"
    az         = "us-east-2a"
    tags = {
      Name = "private"
    }

  }]
}
