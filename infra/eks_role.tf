resource "aws_iam_role" "eks_fiap_role" {
  name = "eks_fiap_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ec2.application-autoscaling.amazonaws.com",
          "eks.amazonaws.com",
      ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.eks_fiap_role.name
  policy_arn = var.ec2_policy_lab_role_arn
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_fiap_role.name
  policy_arn = var.eks_cluster_policy_lab_role_arn
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_fiap_role.name
  policy_arn = var.eks_worker_node_policy_lab_role_arn
}

resource "aws_iam_role_policy_attachment" "amazon_ssm_policy" {
  role       = aws_iam_role.eks_fiap_role.name
  policy_arn = var.amazon_ssm_policy_lab_role_arn
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy" {
  role       = aws_iam_role.eks_fiap_role.name
  policy_arn = var.dynamodb_policy_lab_role_arn
}