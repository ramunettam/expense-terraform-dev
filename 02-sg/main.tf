module "db" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for DB MySQL Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  comman_tags = var.comman_tags
  sg_name = "db"
}

module "backend" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for backend Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  comman_tags = var.comman_tags
  sg_name = "backend"
}

module "frontend" {
  source = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for frontend Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  comman_tags = var.comman_tags
  sg_name = "frontend"
}

## db acceting conecctions from backend
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id = module.db.sg_id
}

## backend acceting conecctions from frontend
resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend.sg_id
}

## frontend acceting conecctions from public
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.db.sg_id
}