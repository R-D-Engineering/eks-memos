output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_sg_id" {
  description = "The ID of the EKS cluster security group"
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "eks_service_account_role_arn" {
  description = "The ARN of the EKS service account role"
  value       = aws_iam_role.memos_pod_role.arn
}

output "external_dns_role_arn" {
  description = "The ARN of the external-dns role"
  value       = aws_iam_role.pod_identity_external_dns.arn
}

output "external_secrets_role_arn" {
  description = "The ARN of the external-secrets role"
  value       = aws_iam_role.external_secrets_role.arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}