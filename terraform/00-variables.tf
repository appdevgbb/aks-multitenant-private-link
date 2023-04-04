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