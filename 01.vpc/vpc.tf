module "vpc" {
      source = "../../terraform-aws-vpc" 
      project_name=var.project_name
      environment=var.environment
      comman_tags=var.comman_tags
      public_subnet_cidrs = var.public_cidrs
      private_subnet_cidrs = var.private_cidrs
      database_subnet_cidrs=var.database_cidrs
  
}