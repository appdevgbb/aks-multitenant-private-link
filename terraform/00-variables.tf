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