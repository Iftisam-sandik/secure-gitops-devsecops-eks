# Application Baseline

## Selected Application

**Application:** Ledgr Budget Tracker  
**Upstream:** yitmeng00/budget-tracker

The application is used as the three-tier workload for this GitOps and DevSecOps project.

## Architecture

- Frontend: React + TypeScript + Vite
- Backend: Node.js + Express + TypeScript
- Database: MySQL
- Architecture: Three-tier

## Baseline Strengths

- Real frontend, backend, and database architecture
- Environment-based database configuration
- Relative `/api` frontend routing
- Existing `/health` backend endpoint
- Deterministic MySQL schema and seed data
- Clear MIT license
- Modern Node.js ecosystem
- Suitable for Docker, Kubernetes, Helm, Argo CD, and EKS

## Known Cleanup Items

The following items were identified before project execution:

1. Use Node.js 24 for the project.
2. Standardize the backend port configuration.
3. Standardize the database password environment variable as `DB_PASSWORD`.
4. Add a proper backend lint script.
5. Add lightweight automated tests for CI.
6. Create production-ready frontend and backend Dockerfiles.
7. Add a database-aware readiness endpoint.
8. Keep MySQL internal-only and use secrets for credentials.
9. Improve transaction consistency where account balance and transaction records are updated together.
10. Do not use the upstream Docker Compose configuration as the final production deployment design.

## Kubernetes Target

The Kubernetes workload will consist of:

- Frontend Deployment
- Backend Deployment
- MySQL StatefulSet
- Internal Services
- Persistent storage for MySQL
- Liveness and readiness probes
- Resource requests and limits
- ConfigMap and Secret configuration

## Important Rule

Application fixes must remain minimal.

The main focus of this repository is GitOps, DevSecOps, Kubernetes, and AWS EKS, not application redevelopment.
