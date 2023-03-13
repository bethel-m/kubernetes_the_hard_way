module "vpc" {
  source = "./vpc"

  vpc_name = "kubernetes_vpc"
  vpc_cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true 
  public_internet_cidr = "10.0.1.0/24"
  public_subnet_name = "kubernetes_subnet"
  kubernetes_IGW = "kubernetes_IGW"
  kubernetes_route_table = "Kubernetes_route_table"
  map_public_ip_on_launch = true
  public_subnet_cidr = "10.0.1.0/24"
  kubernetes_security_group = "kubernetes_security_group"

}

module "elb" {
  source = "./elb"
  depends_on = [
    module.ec2
  ]
  lb_name = "kubernetes-lb"
  internale_facing_lb = false 
  lb_type = "network"
  lb_subnets = [module.vpc.public_subnet]
  lb_target_group_name = "kubernetes-target-group"
  lb_target_group_port = 6443
  lb_target_group_protocol = "TCP"
  lb_target_group_type = "ip"
  target_ip = ""
  lb_listener_port = 443
  lb_listener_protocol = "TCP"
  lb_target_group_vpc_id = module.vpc.vpc_id
  lb_attach_count = length(module.ec2.instance_ip)
  ip_list = module.ec2.instance_ip
  
}

module "ec2" {
  depends_on = [
    module.vpc
  ]
  source = "./ec2"
  master_instance_start_ip = ""
  key_name = "kubernetes_key.pem"
  associate_public_ip_address_on_master = true 
  master_security_groups = [ module.vpc.kube_security_group_id]
  master_instance_types = "t2.micro"
  master_subnet_id = module.vpc.public_subnet
  master_count = 2

  worker_instance_start_ip = ""
  source_destination_check = false
  associate_public_ip_address_on_worker = true
  worker_security_groups = [ module.vpc.kube_security_group_id]
  worker_instance_types = "t2.micro"
  worker_subnet_id = module.vpc.public_subnet
  worker_count = 2
}


