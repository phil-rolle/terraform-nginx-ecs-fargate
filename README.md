# NGINX ECS Fargate Deployment with Terraform

## Overview

This project uses **[Terraform](https://www.terraform.io/downloads)** to deploy a highly available **[NGINX](https://nginx.org/)** service on AWS using [AWS ECS Fargate](https://aws.amazon.com/fargate/) to host a containerized NGINX application. The application sits behind an **Application Load Balancer (ALB)**. Additional features include:

- Basic IAM roles and policies for ECS task execution
- CloudWatch logging (for troubleshooting, etc.)
- VPC with private/public subnets across two availability zones
- Optional auto-scaling*
- Modular, reusable Terraform code/structure

This project was designed as a proof-of-concept to demo Fargate as well as provide a robust, repeatable, and secure way to deploy this infrastructure using Terraform.

## How to Deploy

### Prerequisites

- Terraform CLI (>= 1.3)
- AWS CLI with credentials configured (`aws configure`)
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

3. **(Optional)** Create and customize `terraform.tfvars` - Ignored and not committed to this repository (secure best practice). *This step can be skipped and was not fully tested for this demo*.

   Example:

   ```hcl
   region         = "us-east-1"
   cluster_name   = "nginx-demo"
   desired_count  = 2
   cpu            = "256"
   memory         = "512"
   image_name     = "nginx:alpine"
   vpc_cidr_block = "10.0.0.0/16"

   tags = {
     Environment = "dev"
     Project     = "nginx-demo"
   }


5. Review and apply the plan
   ```bash
   terraform plan
   terraform apply
   ```

6. Wait for deployment and copy the ALB DNS output:
   ```
   alb_dns_name = <your-load-balancer>.elb.amazonaws.com
   ```

7. Access the NGINX service at:
   ```
   http://<alb_dns_name>
   ```
---

### Assumptions and Notes

- You are running in an environment where `aws` CLI credentials are already configured.
- You have permission to create IAM roles, ALB, ECS services, and related infrastructure.
- Resources that can potentially cause conflicts (e.g. already existing resources with the same names as those defined in the Terraform code) do not exist
- Note that this project is simplified and certain hard-coded values may persist for simplicity. In a true production environment, more robust configuration options would be available.

---

### Security Considerations

- IAM roles should follow least privilege principles.
- Security groups should restrict ingress/egress traffic to necessary ports only
- CloudWatch logs are used for auditing/debugging
- Subnets are segmented into public (ALB) and private (ECS)

---

## Design Choices/Rationale

The goal was to create a simple, production-adjacent deployment with less effort required to manage infrastructure and the capability to quickly and easily scale should the solution need to be evolved to support it. 

**Why ECS Fargate?**

**Fargate** removes the need to focus time and effort on server provisioning and capacity management concerns, and was chosen over Kubernetes due to the following reasons (among others):

- Lower management overhead (no control plane to manage, for example)
- Faster startup times
- Cost (cheaper than Kubernetes)
- Complexity (Simpler definitions vs. Helm charts, YAML)
- Use case/time (Fargate works well for singular deployments)
  
Versus a monolithic VM (EC2) deployment, Fargate offers:

- Built-in scaling
- Minimal management (no need to patch)
- Simpler security management (need to harden EC2 OS, for example)
- Native observability (vs. agent installation and config on EC2 instances)

In conclusion, Fargate is an ideal solution for this deployment, which has:

- Low infrastructure requirements
- Is a modular, container-based solution
- Is a single-service, lightweight workload.
   

---

## Areas for Improvement (if given more time)

- Add integration tests to validate deployment success and health.
- Implement CI/CD with GitHub Actions (or other solution) to automatically deploy on commits.
- Production (real-life) consideration: Use Terraform workspaces or Terragrunt for multi-environment separation (dev/staging/prod).
- Parameterize image repository and support blue/green or canary deployments.
- Store Terraform state remotely (e.g., S3 + DynamoDB) for team collaboration.
- Add SSL/HTTPS support via ACM or storing secret(s) in Vault
- Experiment with WAF (Web Application Firewall) on ALB.
- Add auto-scaling features depending on load/request count
- Improve security standpoint (e.g. lock down HTTP)

---

## Project Structure
```
.
├── main.tf                  # Root module (orchestrates all others)
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── security/
│   ├── alb/
│   ├── ecs/
│   └── iam/
└── README.md
```

---

## 📜 License

MIT License
