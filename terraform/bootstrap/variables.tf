variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
  default     = "memos-tfstate"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository to create"
  type        = string
  default     = "memos-ecr"
}

variable "github_repo" {
  description = "The GitHub repository in the format 'owner/repo'"
  type        = string
  default     = "R-D-Engineering/eks-memos"
}