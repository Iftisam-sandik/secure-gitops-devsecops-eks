locals {
  repositories = toset([
    "ledgr-backend",
    "ledgr-frontend"
  ])
}

resource "aws_ecr_repository" "app" {
  #checkov:skip=CKV_AWS_136:ECR repositories use AES-256 encryption at rest; switching existing repositories to KMS would require replacement and is unnecessary for this cost-sensitive lab.

  for_each = local.repositories

  name                 = each.value
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  for_each = aws_ecr_repository.app

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the five newest images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}
