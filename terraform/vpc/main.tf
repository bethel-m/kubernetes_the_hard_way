resource "aws_vpc" "kubernetes_vpc" {
  cidr_block =var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.kubernetes_vpc.id 
  cidr_block = var.public_subnet_cidr 
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    "Name" = var.public_subnet_name
  }
}

resource "aws_internet_gateway" "kubernetes_IGW" {
  vpc_id = aws_vpc.kubernetes_vpc.id 
  tags = {
    "Name" = var.kubernetes_IGW
  }
}
resource "aws_route_table" "kubernetes_route_table" {
  vpc_id=aws_vpc.kubernetes_vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kubernetes_IGW.id
  }
  tags = {
    "Name" = var.kubernetes_route_table
  }
}

resource "aws_route_table_association" "kubernetes_public_route_table_association" {
  subnet_id = aws_subnet.public_subnet.id 
  route_table_id = aws_route_table.kubernetes_route_table.id 
}

resource "aws_security_group" "kubernetes_security_group" {
  name = var.kubernetes_security_group
  vpc_id = aws_vpc.kubernetes_vpc.id 
    ingress {
    description = "SSH"
    from_port = local.ssh_port
    to_port = local.ssh_port
    protocol = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
  ingress{
    protocol = local.tcp_protocol
    to_port = 443
    from_port = 443
    cidr_blocks = local.all_ips
  }

  ingress  {
    protocol = local.tcp_protocol
    to_port = 6443
    from_port = 6443
    cidr_blocks = local.all_ips
  }
  ingress {
    protocol = local.icmp_protocol
    to_port = -1
    from_port = -1
    cidr_blocks = local.all_ips
  }
    ingress  {
    to_port = 0
    from_port = 0
    protocol = local.any_protocol
    cidr_blocks = ["10.200.0.0/16","10.0.0.0/16"]
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
  tags = {
    "Name" = var.kubernetes_security_group
  }
}