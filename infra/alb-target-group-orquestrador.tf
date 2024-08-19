# target group node port 30011 - MS ORQUESTRADOR
resource "aws_lb_target_group" "target-group-ms-orquestrador" {
  name        = "target-group-ms-orquestrador"
  port        = 30011
  target_type = "instance"
  protocol    = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path     = "/actuator/health"
    port     = 30011
    matcher  = "200"
    interval = 90
    timeout  = 60
  }
}

resource "aws_lb_target_group_attachment" "attach-ms-orquestrador" {
  target_group_arn = aws_lb_target_group.target-group-ms-orquestrador.arn
  target_id        = data.aws_instance.ec2.id
  port             = 30011
}

resource "aws_lb_listener_rule" "listener-rule-ms-orquestrador" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 300

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-ms-orquestrador.arn
  }

  condition {
    http_header {
      http_header_name = "microsservice"
      values           = ["ms_orquestrador"]
    }
  }
}