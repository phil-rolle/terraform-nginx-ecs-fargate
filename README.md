# NGINX ECS Fargate Deployment with Terraform

## Overview

This project uses Terraform to deploy a highly available NGINX service on AWS using:

- AWS ECS Fargate
- Application Load Balancer (ALB)
- CloudWatch logging
- IAM roles and policies
- Private and public subnets
- Modular, reusable Terraform code

## How to Deploy

### Prerequisites

- Terraform CLI (>= 1.3)
- AWS CLI with credentials configured
- AWS account with appropriate IAM permissions

### Steps

1. Clone the repository
   ```bash
   git clone git@github.com:phil-rolle/terraform-nginx-ecs-fargate.git
   cd terraform-nginx-ecs-fargate
   ```

2. Initialize Terraform
   ```bash
   terraform init
   ```

3. Review and apply the plan
   ```bash
   terraform plan
   terraform apply
   ```

4. Wait for deployment and copy the ALB DNS output:
   ```
   alb_dns_name = <your-load-balancer>.elb.amazonaws.com
   ```

5. Access your NGINX service at:
   ```
   http://<alb_dns>
   ```
---

### Assumptions

- You are running in an environment where `aws` CLI credentials are already configured.
- You have permission to create IAM roles, ALB, ECS services, and related infrastructure.

---

## Areas for Improvement (if given more time)

- Add integration tests to validate deployment health.
- Implement CI/CD with GitHub Actions to automatically deploy on commits.
- Use Terraform workspaces or Terragrunt for environment separation (dev/staging/prod).
- Parameterize image repository and support blue/green or canary deployments.
- Store Terraform state remotely (e.g., S3 + DynamoDB) for team collaboration.
- Add SSL/HTTPS support via ACM or storing secrets in Vault

---

## 📜 License

MIT License
