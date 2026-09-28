# Project Architecture

## Development Environment

```text
Windows PC
    |
    | SSH
    v
Temporary AWS EC2 Lab
    |
    +-- Docker
    +-- kind
    +-- kubectl
    +-- Helm
    +-- Argo CD
    +-- DevSecOps tools
    |
    v
kind Kubernetes Cluster
    |
    +-- Frontend
    +-- Backend
    +-- MySQL
```

## Secure Delivery Flow

```text
Developer Change
      |
      v
GitHub
      |
      v
GitHub Actions
      |
      +-- Tests
      +-- Gitleaks
      +-- CodeQL
      +-- Trivy
      +-- Checkov
      +-- Docker Build
      +-- Image Scan
      +-- SBOM
      +-- Cosign
      |
      v
Container Registry
      |
      v
Git Desired State Update
      |
      v
Argo CD
      |
      v
Kubernetes / EKS
```

## Application Flow

```text
User
 |
 v
Frontend
 |
 | /api
 v
Backend
 |
 v
MySQL
```

## Final AWS Environment

```text
GitHub Actions
      |
      | OIDC
      v
AWS IAM
      |
      v
ECR

Git Repository
      |
      v
Argo CD
      |
      v
AWS EKS
      |
      +-- Frontend
      +-- Backend
      +-- MySQL
      |
      v
AWS Load Balancer
```

The final AWS environment is intentionally short-lived to control cost.
