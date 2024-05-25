variable "project_name" {
      default = "expense"
  
}

variable "environment" {
      default = "dev"
  
}

variable "comman_tags" {
      type = map
      default = {
            project="expense"
            environment="dev"
            Terraform="true"
      }
}