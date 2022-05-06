provider "aws" { 
  access_key = var.provider_access_key
  secret_key = var.provider_secret
  region = var.provider_region
}

data "aws_vpc" "main" {
  default = true
}

# data "aws_instance" "name" {
#   # filter {
#   #   name   = "image-id"
#   #   values = ["ami-xxxxxxxx"]
#   # }

#   filter {
#     name   = "tag:Name"
#     values = ["server-1"]
#   }
# }

resource "aws_subnet" "main" {
  vpc_id = data.aws_vpc.main.id
  availability_zone = var.provider_availability_zone
  cidr_block = cidrsubnet(data.aws_vpc.main.cidr_block, 4, 1)
}

resource "aws_instance" "main" {
  ami = var.provider_ami
  instance_type = var.provider_instance_type

  tags = {
    "Name" = "Main"
  }
}

output "public_ip" {
  value = aws_instance.main.public_ip
}

output "existing_vpc_id" {
  value = data.aws_vpc.main.id
}

output "vpc_cidr" {
  value = data.aws_vpc.main.cidr_block
}
