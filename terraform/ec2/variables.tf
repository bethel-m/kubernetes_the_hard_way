variable "associate_public_ip_address_on_master" {
  description = "this is an option to enable associate public ip on master node(controllers)"
  type = bool
}

variable "master_security_groups"{
  description = "this is the security groups that will be attatched to the master"
  type = list
}

variable "master_instance_types" {
  description="this is the instance type of the master nodes"
  type=string
}
variable "master_instance_start_ip"{
  description = "this is the base ip that will increment to form master ip addresses, eg 10.0.0.0, then the first master ip becomes 10.0.0.1 etc"
  type = string
}

variable "master_subnet_id" {
  description = "this is the subnet to deploy the master nodes in"
  type =string
}
variable "master_count" {
  description = "this is the number of master nodes to provision "
  type = number
}



variable "associate_public_ip_address_on_worker" {
  description = "this is an option to enable associate public ip on worker"
  type = bool
}

variable "worker_security_groups"{
  description = "this is the security groups that will be attatched to the worker"
  type = list
}

variable "worker_instance_types" {
  description="this is the instance type of the worker nodes"
  type=string
}
variable "worker_instance_start_ip"{
  description = "this is the base ip that will increment to form worker ip addresses, eg 10.0.0.0, then the first master ip becomes 10.0.0.1 etc"
  type = string
}

variable "worker_subnet_id" {
  description = "this is the subnet to deploy the worker nodes in"
  type =string
}

variable "key_name" {
  description = "this is the name of the generated key pai"
  type = string
}

variable "source_destination_check" {
  description = "this is an option to check the source destination"
  type=bool
}
variable "worker_count" {
  description = "this is the number of worker nodes to provision"
  type=number
}