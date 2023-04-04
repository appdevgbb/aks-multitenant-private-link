variable "prefix" {
  type = string
  default = "gbb"
}

variable "location" {
  type = string
  default = "eastus"
}

variable "nginx_jwt_path" {
  type = string
  default = "./nginx-repo.jwt"
}

variable "auto_approval_subscription_ids" {
  type = list
  default = []
}

variable "visibility_subscription_ids" {
  type = list
  default = []
}

variable "admin_username" {
  type = string
  default = "gbbadmin"
}

variable "ssh_public_key_path" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "private_dns_zone_name" {
  type = string
  default = "testapp.io"
}