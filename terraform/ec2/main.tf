data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name= "architecture"
    values=["x86_64"]
  }
  filter {
    name="root-device-type"
    values=["ebs"]
  }

  owners = ["099720109477"] # Canonical

}

resource "aws_key_pair" "kubernetes_key" {
  key_name = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "name" {
  content = tls_private_key.rsa.private_key_pem
  filename = var.key_name
}




resource "aws_instance" "kubernetes_controller" {
  associate_public_ip_address = var.associate_public_ip_address_on_master
  ami = data.aws_ami.ubuntu.id
  count = var.master_count 
  key_name = aws_key_pair.kubernetes_key.key_name
  security_groups = var.master_security_groups
  instance_type = var.master_instance_types
  private_ip = "10.0.1.1${count.index}"
  user_data = "name=controler-${count.index}"
  subnet_id = var.master_subnet_id 
  source_dest_check = var.source_destination_check
  tags = {
    "Name" = "master-${count.index}"
  }

}

resource "aws_instance" "kubernetes_worker" {
  associate_public_ip_address = var.associate_public_ip_address_on_worker
  ami = data.aws_ami.ubuntu.id 
  count = var.worker_count
  key_name = aws_key_pair.kubernetes_key.key_name
  security_groups = var.worker_security_groups
  instance_type = var.worker_instance_types
  private_ip = "10.0.1.2${count.index}"
  user_data = "name=worker-${count.index}"
  subnet_id = var.worker_subnet_id
  source_dest_check = var.source_destination_check
  tags = {
    "Name" = "worker-${count.index}"
  }
}