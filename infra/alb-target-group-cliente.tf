# target group node port 30007 - MS CLIENTE
resource "aws_lb_target_group" "target-group-ms-cliente" {
  name        = "target-group-ms-cliente"
  port        = 30007
  target_type = "instance"
  protocol    = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path     = "/actuator/health"
    port     = 30007
    matcher  = "200"
    interval = 90
    timeout  = 60
  }
}

resource "aws_lb_target_group_attachment" "attach-ms-cliente" {
  target_group_arn = aws_lb_target_group.target-group-ms-cliente.arn
  target_id        = data.aws_instance.ec2.id
  port             = 30007
}

resource "aws_lb_listener_rule" "listener-rule-ms-cliente" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 400

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-cliente.arn
  }

  condition {
    http_header {
      http_header_name = "microsservice"
      values           = ["ms_cliente"]
    }
  }
}