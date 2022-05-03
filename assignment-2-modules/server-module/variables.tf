variable "provider_ami" {
  type = string
  default = "ami-04505e74c0741db8d"
}

variable "provider_instance_type" {
  type = string
  default = "t2.micro"
}

variable "provider_availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "vpc_id" {
  type = string
}