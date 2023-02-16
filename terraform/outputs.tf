output "vpc_id" {
  description = "this is the id of the created vpc"
  value = module.vpc.vpc_id
}

output "public_subnet" {
  description = "this id of the public subnet"
  value = module.vpc.public_subnet
}
output "security_groups" {
  description = "this is the id of the security group attatched to the vpc"
  value = module.vpc.kube_security_group_id
}
output "instance_ip" {
  description = "this is the ip addresses of the master nodes"
  value = module.ec2.instance_ip
}