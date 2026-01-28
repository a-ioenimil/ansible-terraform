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
  content = <<EOT
[webservers]
${module.compute.instance_id} ansible_connection=aws_ssm ansible_aws_ssm_region=us-east-1 ansible_user=ssm-user
EOT
  filename = "${path.module}/../ansible/inventory.ini"
}
