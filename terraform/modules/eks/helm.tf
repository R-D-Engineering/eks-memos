resource "helm_release" "external_dns" {
  name             = "external-dns"
  version          = "1.21.1"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  namespace        = "external-dns"
  create_namespace = true
  take_ownership   = true

  # The cloudflare-api-token Secret is provisioned later by External Secrets
  # Operator (managed by ArgoCD in k8s/secrets/). Don't block Terraform on
  # Pod readiness — external-dns will recover once the Secret exists.
  wait          = false
  wait_for_jobs = false

  values = [
    yamlencode({
      provider = "cloudflare"
      env = [
        {
          name = "CF_API_TOKEN"
          valueFrom = {
            secretKeyRef = {
              name = "cloudflare-api-token"
              key  = "cloudflare-api-token"
            }
          }
        }
      ]
      txtOwnerId = var.cluster_name
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  version          = "2.6.0"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true
  take_ownership   = true

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  version          = "v1.20.2"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  take_ownership   = true
  values = [
    yamlencode({
      crds = {
        enabled = true
      }
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "traefik" {
  name             = "traefik"
  version          = "41.0.2"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  namespace        = "traefik"
  create_namespace = true
  take_ownership   = true

  values = [
    yamlencode({
      service = {
        type = "LoadBalancer"
        annotations = {
          "service.beta.kubernetes.io/aws-load-balancer-type"   = "nlb"
          "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
        }
      }
    })
  ]

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  version          = "9.7.0"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argo-cd"
  create_namespace = true
  take_ownership   = true

  depends_on = [
    aws_eks_node_group.eks_node_group,
    aws_eks_addon.core_dns
  ]
}
