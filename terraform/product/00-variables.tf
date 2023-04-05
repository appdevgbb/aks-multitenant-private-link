variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "nginx_jwt_path" {
  type = string
  description = "The nginx-repo.jwt token that was supplied to you via your F5 trial/dev/enterprise subscription.  Should be placed in the tf root module directory."
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
}

variable "ssh_public_key_path" {
  type = string
}

variable "vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "myip" {
  type = string
}
