variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "memos-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "availability_zones" {
  description = "A list of availability zones to use for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "availability_mode" {
  description = "The availability mode for the NAT gateway (single or regional)"
  type        = string
  default     = "regional"
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "memos-eks-cluster"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster"
  type        = string
  default     = "1.35"
}

variable "desired_size" {
  description = "The desired number of worker nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of worker nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of worker nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during an update"
  type        = number
  default     = 1
}

variable "db_instance_identifier" {
  description = "The name of the database instance."
  type        = string
  default     = "memos-db-instance"
}

variable "db_engine" {
  description = "The database engine to use."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The version of the database engine to use."
  type        = string
  default     = "18.4"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes."
  type        = number
  default     = 20
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
  default     = "memos"
}

variable "db_username" {
  description = "The username for the database."
  type        = string
  default     = "memos_user"
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = true
}

variable "eks_namespace" {
  description = "The namespace to use for the EKS cluster"
  type        = string
  default     = "memos-namespace"
}

variable "eks_service_account_name" {
  description = "The name of the service account to use for the EKS cluster"
  type        = string
  default     = "memos-service-account"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
  default     = "ai-engineering-aph.online"
}

variable "memos_access_policy_arn" {
  description = "The ARN of the IAM policy for Memos access"
  type        = string
  default     = "arn:aws:iam::681302732440:role/terraform-plan-role"
}

