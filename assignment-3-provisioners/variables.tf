# Environment var, format: export TF_VAR_provider_access_key=(value)
variable "provider_access_key" {
  type      = string
  sensitive = true
}

# Environment var, format: export TF_VAR_provider_secret=(value)
variable "provider_secret" {
  type      = string
  sensitive = true
}

# Environment var, format: export TF_VAR_provider_access_key=(value)
variable "provider_instance_key_name" {
  type      = string
  sensitive = true
}

variable "provider_region" {
  type = string
}

variable "provider_ami" {
  type = string
  default = "ami-04505e74c0741db8d"
}

variable "provider_instance_type" {
  type = string
  default = "t2.micro"
}

variable "aws_public_key" {
  type = string
}

variable "aws_private_key_path" {
  type = string
}
