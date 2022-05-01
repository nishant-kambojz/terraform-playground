/********************* Variables *******************/
# Environment var, format: export TF_VAR_provider_access_key=(value)
variable "provider_access_key" {
  type = string
  sensitive = true
}

# Environment var, format: export TF_VAR_provider_secret=(value)
variable "provider_secret" {
  type = string
  sensitive = true
}

# Environment var, format: export TF_VAR_provider_instance_key_name=(value)
variable "provider_instance_key_name" {
  type = string
  sensitive = true
}

variable "provider_region" {
  type = string
}

variable "provider_ami" {
  type = string
}

variable "provider_instance_type" {
  type = string
}

variable "provider_availability_zone" {
  type = string
}

variable "server_private_ips" {
  type = list
}
/****************************************************/


/**************** Provider Details ********************/
provider "aws" {
  region     = var.provider_region
  access_key = var.provider_access_key
  secret_key = var.provider_secret
}
/******************************************************/


/****************** Assignment Steps *********************/
# # 1. Create vpc
resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
}

# # 2. Create Internet Gateway
resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id

  # tags = {
  #   Name = "main"
  # }
}

# # 3. Create Custom Route Table
resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }

  tags = {
    Name = "example"
  }
}


# # 4. Create a Subnet 
resource "aws_subnet" "test-subnet" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Main"
  }
}

# # 5. Associate subnet with Route Table
resource "aws_route_table_association" "test-rts" {
  subnet_id      = aws_subnet.test-subnet.id
  route_table_id = aws_route_table.test-rt.id
}

# # 6. Create Security Group to allow port 22,80,443
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow Web Traffic"
  vpc_id      = aws_vpc.test-vpc.id

  ingress {
    description      = "Web from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# # 7. Create a network interface with an ip in the subnet that was created in step 4
resource "aws_network_interface" "test_ni" {
  subnet_id       = aws_subnet.test-subnet.id
  private_ips     = var.server_private_ips
  security_groups = [aws_security_group.allow_web.id]

  # attachment {
  #   instance     = aws_instance.test.id
  #   device_index = 1
  # }
}

# # 8. Assign an elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.test_ni.id
  associate_with_private_ip = var.server_private_ips[0]
  depends_on = [
    aws_internet_gateway.test-igw
  ]
}

# # 9. Create Ubuntu server and install/enable apache2
resource "aws_instance" "apache-web-server" {
  ami           = var.provider_ami # us-west-2
  instance_type = var.provider_instance_type
  availability_zone = var.provider_availability_zone
  key_name = var.provider_instance_key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.test_ni.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo First webpage hosted using Terraform > /var/www/html/index.html'
                EOF

}
/***********************************************/


/****************** Outputs ********************/
output "public_ip" {
  value = aws_instance.apache-web-server.public_ip
}

output "private_ip" {
  value = aws_instance.apache-web-server.private_ip
}

output "private_dns" {
  value = aws_instance.apache-web-server.private_dns
}

output "public_dns" {
  value = aws_instance.apache-web-server.public_dns
}

output "server_id" {
  value = aws_instance.apache-web-server.id
}
/************************************************/
