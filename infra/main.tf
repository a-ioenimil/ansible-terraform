module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
}

module "compute" {
  source = "./modules/compute"

  project_name              = var.project_name
  environment               = var.environment
  instance_type             = var.instance_type
  security_group_ids        = [module.security.security_group_id]
  iam_instance_profile_name = module.security.instance_profile_name
}

resource "local_file" "ansible_inventory" {
  content  = <<-EOT
---
all:
  children:
    webservers:
      hosts:
        ${module.compute.instance_id}:
          ansible_connection: aws_ssm
          ansible_aws_ssm_region: ${var.aws_region}
          ansible_aws_ssm_bucket_name: ""
          ansible_aws_ssm_s3_addressing_style: virtual
EOT
  filename = "${path.module}/../ansible/inventory.yml"
}
