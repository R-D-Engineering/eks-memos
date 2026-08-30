data "aws_caller_identity" "current" {}

resource "aws_iam_role" "pod_identity_external_dns" {
  name = "${var.cluster_name}-pod-identity-external-dns"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "external-dns"
  service_account = "external-dns"
  role_arn        = aws_iam_role.pod_identity_external_dns.arn
  depends_on      = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role" "external_secrets_role" {
  name = "${var.cluster_name}-pod-identity-external-secrets"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "external_secrets_policy" {
  name = "${var.cluster_name}-pod-identity-external-secrets-policy"
  role = aws_iam_role.external_secrets_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          var.rds_secret_arn,
          "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:grafana/admin-*",
          aws_secretsmanager_secret.cloudflare_api_token.arn
        ]
      }
    ]
  })
}

resource "aws_eks_pod_identity_association" "external_secrets" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "external-secrets"
  service_account = "external-secrets"
  role_arn        = aws_iam_role.external_secrets_role.arn
  depends_on      = [aws_eks_cluster.eks_cluster]
}
