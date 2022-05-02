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

# # 2. Create a Subnet 
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.provider_availability_zone

  tags = {
    Name = "Main"
  }
}

# # 3. Create Ubuntu server and install/enable apache2
resource "aws_instance" "main" {
  ami               = var.provider_ami # us-west-2
  instance_type     = var.provider_instance_type
  availability_zone = var.provider_availability_zone
  subnet_id         = aws_subnet.main.id
}
