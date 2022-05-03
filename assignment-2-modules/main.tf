/**************** Provider Details ********************/
provider "aws" {
  region     = var.provider_region
  access_key = var.provider_access_key
  secret_key = var.provider_secret
}
/******************************************************/

# # 1. Create vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "server" {
  source = "./server-module"
  vpc_id = aws_vpc.main.id
}

output "server_id" {
  value = module.server.ec2_instance.id
}