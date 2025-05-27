# main.tf - Root module for this demo

# define modules for iam, vpc, security, alb, ecs
module "iam" {
  source = "./modules/iam"
  name   = "nginx-demo-ecs-task-role"
  tags   = var.tags
}

module "vpc" { 
  source = "./modules/vpc"
  vpc_id = module.vpc.vpc_id
}

module "security" {
    source = "./modules/security"
    vpc_id = module.vpc.vpc_id
}

module "alb" {
    source = "./modules/alb"
    name = "nginx-demo-alb"
    vpc_id = module.vpc.vpc_id
    alb_sg_id = module.security.alb_sg_id
    public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
    source = "./modules/ecs"

  cluster_name       = "nginx-demo-ecs-cluster"
  cpu                = var.ecs_cpu
  memory             = var.ecs_memory
  image_name         = var.ecs_image_name
  task_role_arn      = module.iam.ecs_task_role_arn
  execution_role_arn = module.iam.ecs_task_role_arn
  desired_count      = var.ecs_desired_count
  private_subnets    = module.vpc.public_subnet_ids   # Ideally private, but for now using public subnets
  ecs_sg_id          = module.security.ecs_task_sg_id
  target_group_arn   = module.alb.target_group_arn
  listener_arn       = module.alb.listener_arn
  log_group_name     = var.log_group_name
  region             = var.region
}