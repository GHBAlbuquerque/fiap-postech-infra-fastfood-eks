# target group node port 30008 - MS PAGAMENTO
resource "aws_lb_target_group" "target-group-ms-pagamento" {
  name        = "target-group-ms-pagamento"
  port        = 30010
  target_type = "instance"
  protocol    = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path     = "/actuator/health"
    port     = 30010
    matcher  = "200"
    interval = 90
    timeout  = 60
  }
}

resource "aws_lb_target_group_attachment" "attach-ms-pagamento" {
  target_group_arn = aws_lb_target_group.target-group-ms-pagamento.arn
  target_id        = data.aws_instance.ec2.id
  port             = 30010
}

resource "aws_lb_listener_rule" "listener-rule-ms-pagamento" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 300

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-pagamento.arn
  }

  condition {
    http_header {
      http_header_name = "microsservice"
      values           = ["ms_pagamento"]
    }
  }
}