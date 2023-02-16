  variable "lb_name" {
    description = "this is the name of the load balancer"
    type = string
  }
  variable "internale_facing_lb" {
    description = "this is an option to choose if the load balancer faces the internet"
    type = bool
  }
  variable "lb_type" {
    description = "this is the type of load balancer you are creating"
    type = string 
  }
  variable "lb_subnets" {
    description = "this is the list of subnets that the load balancer is attached to"
    type = list
  }


  variable "lb_target_group_name"{
    description = "this is the name of the target group"
    type= string 
  }
  variable "lb_target_group_port"{
    description = "this is the accessing port of the target group"
    type=number
  }
  variable "lb_target_group_protocol" {
    description = "this is the protocol the target group should use"
    type = string
  }
  variable "lb_target_group_type" {
    description = "this is the type of the target group"
    type = string
  }
  variable "lb_target_group_vpc_id" {
    description = "this is the vpc id of the target group"
    type= string 
  }

  variable "target_ip" {
    description = "this is the group of ip addresses that is attatched to the loadbalancer"
    type=string
  }
  variable "lb_listener_port" {
    description = "this is the port for the load balancer listener"
    type=string
  }
  variable "lb_listener_protocol" {
    description = "this is the protocol for the load balancer listener"
    type=string
  }
  variable "lb_attach_count" {
    description = "this is the number of target group attachement to be made(should correspond to ips of intstances)"
    type=string
  }
  variable "ip_list" {
    description = "this is the list of the ips of the master nodes"
    type = list
  }