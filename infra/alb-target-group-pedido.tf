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

resource "aws_lb_listener_rule" "listener-rule-ms-pedido" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-pedido.arn
  }

  condition {
    http_header {
      http_header_name = "microsservice"
      values           = ["ms_pedido"]
    }
  }
}