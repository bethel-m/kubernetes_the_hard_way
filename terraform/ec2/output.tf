output "instance_ip" {
  description = "this is the ip address of a particular instance"
  value = aws_instance.kubernetes_controller[*].private_ip
}