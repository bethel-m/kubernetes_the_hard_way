variable "vpc_name" {
  description = "this is the name of the vpc"
  type = string
}

variable "vpc_cidr_block" {
  description = "this is the cidr block of the vpc"
  type = string
}

variable "enable_dns_hostnames" {
  description = "this is a choice to enable dns hostname or not"
  type = bool
}
variable "enable_dns_support"{
  description = "this is a choice to enable dns support or not"
  type = bool
}

variable "public_subnet_cidr" {
  description = "this is the public subnet cidr block"
  type = string
}
variable "public_subnet_name" {
  description = "this is the name of the public subnet"
  type = string
}
variable "kubernetes_IGW" {
  description="this is the name of the internet gateway"
  type = string
}

variable "kubernetes_route_table" {
  description="this is the route table of the vpc"
  type = string
}
variable "map_public_ip_on_launch" {
 description="this is an option to map a public ip on launch to instances created in this subnet"
 type = bool
}
variable "public_internet_cidr" {
  description="this represents the cidr of the public internet for the route table"
  type = string
}

variable "kubernetes_security_group" {
  description="this refers to the security group attatched to the vpc"
  type = string 
}