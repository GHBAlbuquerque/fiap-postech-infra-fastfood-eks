# target group node port 30009 - MS pedido
resource "aws_lb_target_group" "target-group-ms-pedido" {
  name        = "target-group-ms-pedido"
  port        = 30009
  target_type = "instance"
  protocol    = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path     = "/actuator/health"
    port     = 30009
    matcher  = "200"
    interval = 90
    timeout  = 60
  }
}

resource "aws_lb_target_group_attachment" "attach-ms-pedido" {
  target_group_arn = aws_lb_target_group.target-group-ms-pedido.arn
  target_id        = data.aws_instance.ec2.id
  port             = 30009
}


resource "aws_lb_listener" "listener-ms-pedido" {
  load_balancer_arn = aws_alb.alb-cluster-fiap.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-pedido.arn
  }
}

resource "aws_lb_listener_rule" "listener-rule-ms-pedido" {
  listener_arn = aws_lb_listener.listener-ms-pedido.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-pedido.arn
  }

  condition {
    host_header {
      values = ["ms-pedido"]
    }
  }
}