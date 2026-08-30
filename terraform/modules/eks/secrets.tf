# Metadata-only secret; the token value is populated out-of-band via AWS CLI
# to keep it out of Terraform state. See README / runbook.
resource "aws_secretsmanager_secret" "cloudflare_api_token" {
  name                    = "cloudflare/api-token"
  description             = "Cloudflare API token consumed by external-dns via External Secrets Operator"
  recovery_window_in_days = 0

  tags = {
    ManagedBy = "terraform"
    Component = "external-dns"
    Cluster   = var.cluster_name
  }
}
