variable "aws_region" {
  description = "AWS region for the GitOps lab"
  type        = string
  default     = "ap-south-1"
}

variable "admin_cidr" {
  description = "Public IP CIDR allowed to SSH into the lab server"
  type        = string
}

variable "public_key_path" {
  description = "Path to the existing SSH public key"
  type        = string
}
