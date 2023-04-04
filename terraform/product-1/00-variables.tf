variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "nginx_jwt_path" {
  type = string
}

variable "auto_approval_subscription_ids" {
  type = list
  default = []
}

variable "visibility_subscription_ids" {
  type = list
  default = []
}