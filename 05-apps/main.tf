module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-backend"

  instance_type          = "t2.micro"
  ami = data.aws_ami.ami_info.id
  
  vpc_security_group_ids = [data.aws_ssm_parameter.private_subnet_ids.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
      var.comman_tags,
      { Name="${var.project_name}-${var.environment}-backend"}
  )
}

module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-frontend"

  instance_type          = "t2.micro"
  ami = data.aws_ami.ami_info.id
  
  vpc_security_group_ids = [data.aws_ssm_parameter.public_subnet_ids.value]
  subnet_id              = local.public_subnet_id

  tags = merge(
      var.comman_tags,
      { Name="${var.project_name}-${var.environment}-frontend"}
  )
}

module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-ansible"

  instance_type          = "t2.micro"
  ami = data.aws_ami.ami_info.id
  
  vpc_security_group_ids = [data.aws_ssm_parameter.public_subnet_ids.value]
  subnet_id              = local.public_subnet_id

  tags = merge(
      var.common_tags,
      { Name="${var.project_name}-${var.environment}-ansible"}
  )
}