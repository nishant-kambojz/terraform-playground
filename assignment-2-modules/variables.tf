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

# Environment var, format: export TF_VAR_provider_instance_key_name=(value)
variable "provider_instance_key_name" {
  type      = string
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
  type = list(any)
}
