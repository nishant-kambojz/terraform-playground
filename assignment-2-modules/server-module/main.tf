terraform {
  required_version = ">= 0.12"
}

resource "aws_subnet" "main" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.provider_availability_zone

  tags = {
    Name = "Main Subnet"
  }
}

resource "aws_instance" "main" {
  ami               = var.provider_ami
  instance_type     = var.provider_instance_type
  availability_zone = var.provider_availability_zone
  subnet_id         = aws_subnet.main.id
}
