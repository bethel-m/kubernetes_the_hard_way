output "vpc_id" {
  description = "this is the id of the vpc"
  value = aws_vpc.kubernetes_vpc.id
}
output "public_subnet" {
  description = "this is the public subnet id"
  value = aws_subnet.public_subnet.id 
}

output "kube_security_group_id" {
  description = "this is the id of the security group attatched to the vpc"
  value = aws_security_group.kubernetes_security_group.id
}