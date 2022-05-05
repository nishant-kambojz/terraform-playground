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

variable "provider_region" {
  type = string
}

variable "provider_region_west" {
  type = string
}

variable "provider_ami_west" {
  type = string
}

variable "provider_ami" {
  type = string
}

variable "provider_instance_type" {
  type = string
}

