resource "aws_eks_cluster" "eks_cluster_fiap_postech" {
  name     = "eks_cluster_fiap_postech"
  role_arn = var.lab_role_arn

  vpc_config {
    subnet_ids         = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
    security_group_ids = [aws_security_group.sg.id]
  }
}

resource "aws_eks_node_group" "eks_node_group_fiap_postech" {
  cluster_name    = aws_eks_cluster.eks_cluster_fiap_postech.name
  node_group_name = "eks_node_group_fiap_postech"
  node_role_arn   = var.lab_role_arn
  subnet_ids      = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}


output "endpoint" {
  value = aws_eks_cluster.eks_cluster_fiap_postech.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster_fiap_postech.certificate_authority[0].data
}




