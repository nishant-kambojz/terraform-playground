provider "aws" { 
  access_key = var.provider_access_key
  secret_key = var.provider_secret
  region = var.provider_region
}

/************* count Meta Parameter ****************/
# resource "aws_instance" "main" {
#   count = 2
#   ami = var.provider_ami
#   instance_type = var.provider_instance_type

#   tags = {
#     "Name" = "Server ${count.index+1}"
#   }
# }
# output "public_ip_list" {
#   value = aws_instance.main[*].public_ip
# }
/****************************************************/


/************ for_each Meta Parameter ****************/
# resource "aws_instance" "main" {
#   for_each = {
#     "instance_1" = "Instance-1"
#     "instance_2" = "Instance-2"
#   }

#   ami = var.provider_ami
#   instance_type = var.provider_instance_type

#   tags = {
#     "Name" = "Server ${each.value}"
#   }
# }
# output "instance_1_public_ip" {
#   value = aws_instance.main["instance_1"].public_ip
# }
# output "instance_2_public_ip" {
#   value = aws_instance.main["instance_2"].public_ip
# }
/*******************************************************/

/************* provider(alias) Meta Parameter ****************/
provider "aws" {
  access_key = var.provider_access_key
  secret_key = var.provider_secret
  region = var.provider_region_west
  alias = "west"
}

resource "aws_instance" "main" {
  provider = aws.west
  ami = var.provider_ami_west
  instance_type = var.provider_instance_type

  tags = {
    "Name" = "Main"
  }
}
output "public_ip" {
  value = aws_instance.main.public_ip
}
/*************************************************************/


/************* Other Meta Parameter ****************/
// - depends_on (Used in previous assignments)
// - lifecycle (Will work in further assignments)
/***************************************************/