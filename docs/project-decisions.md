# Project Decisions

## Project

**Name:** Secure GitOps & DevSecOps Delivery Platform on AWS EKS

**Application:** Ledgr Budget Tracker  
**Upstream:** yitmeng00/budget-tracker

The application is used as the workload for demonstrating GitOps, DevSecOps, Kubernetes, and AWS EKS. Application development itself is not the main focus.

## Application Architecture

- Frontend: React + TypeScript + Vite
- Backend: Node.js + Express + TypeScript
- Database: MySQL
- Architecture: Three-tier

## Development Strategy

The project will not start directly on EKS.

Development flow:

1. Temporary AWS EC2 lab
2. Docker + kind
3. Kubernetes foundation
4. Helm
5. Argo CD
6. GitHub Actions
7. DevSecOps security gates
8. SBOM and image signing
9. Full kind validation
10. Final AWS EKS validation

EKS will only be created after the workflow is proven in kind.

## AWS

- Region: ap-south-1
- Lab OS: Ubuntu Server 26.04 LTS
- Lab EC2: t3.large
- Final EKS workers: 2 x t3.medium
- No NAT Gateway
- No RDS
- No managed Prometheus/Grafana
- ALB only during final validation

## Budget

- Target total cost: about $7
- Absolute ceiling: $10
- Stop the lab EC2 when not actively working
- Keep EKS lifetime as short as possible
- Do not leave EKS or ALB running overnight unnecessarily

## GitOps

Git is the deployment source of truth.

Argo CD will:
- automatically sync desired state
- detect drift
- self-heal
- deploy version changes
- demonstrate rollback through Git revert

## DevSecOps

Required tools:

- Gitleaks
- CodeQL
- Trivy
- Checkov
- Syft
- Cosign

Security failures must be demonstrated using controlled test scenarios only.

Real credentials must never be committed.

## AWS Authentication

GitHub Actions will use AWS OIDC with least-privilege IAM.

Long-lived AWS access keys will not be stored in GitHub Secrets.

## Observability

This project will use only minimal health validation.

A full Prometheus/Grafana/Loki platform will not be rebuilt because observability is not the primary focus of this project.
