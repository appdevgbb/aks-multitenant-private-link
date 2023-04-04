variable "prefix" {
  type = string
}

variable "index" {
  type = string
}

variable "customer_name" {
  type = string
}

variable "location" {
  type = string
}

variable "pls_id" {
  type = string
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

variable "private_dns_zone_name" {
  type = string
}