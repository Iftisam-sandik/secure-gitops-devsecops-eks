output "repository_urls" {
  description = "ECR repository URLs for Ledgr application images"

  value = {
    for name, repository in aws_ecr_repository.app :
    name => repository.repository_url
  }
}

output "github_actions_ecr_role_arn" {
  description = "IAM role assumed by GitHub Actions through OIDC"
  value       = aws_iam_role.github_actions_ecr.arn
}

output "github_oidc_provider_arn" {
  description = "GitHub Actions OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.github.arn
}
