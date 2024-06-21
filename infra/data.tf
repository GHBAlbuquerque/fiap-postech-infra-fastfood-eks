data "aws_instance" "ec2" {
  depends_on = [aws_eks_cluster.eks_cluster_fiap_postech, aws_eks_node_group.eks_node_group_fiap_postech]
  filter {
    # cria filtro para buscar instancias EC2 que estao com a tag 'nodegroup-name' com valor <nome-do-cluster>
    name   = "tag:eks:nodegroup-name"
    values = ["eks_node_group_fiap_postech"] #nome do node group
  }
}