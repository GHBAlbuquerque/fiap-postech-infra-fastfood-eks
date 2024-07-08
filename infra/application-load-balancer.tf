resource "aws_alb" "alb-cluster-fiap" {
  depends_on         = [aws_eks_cluster.eks_cluster_fiap_postech]
  name               = "alb-cluster-fiap"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
  security_groups    = [aws_security_group.sg.id]
  idle_timeout       = 60
}



output "dns_loadbalancer" {
  value = aws_alb.alb-cluster-fiap.dns_name
}
