resource "aws_lb" "kubernetes_lb" {
  name = var.lb_name 
  internal = var.internale_facing_lb
  load_balancer_type = var.lb_type 
  subnets = var.lb_subnets
  tags = {
    "Name" = var.lb_name
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name = var.lb_target_group_name
  port = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  target_type = var.lb_target_group_type
  vpc_id = var.lb_target_group_vpc_id
}

resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  count = var.lb_attach_count
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id =  var.ip_list[count.index]
  port = var.lb_target_group_port
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.kubernetes_lb.arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
