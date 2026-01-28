
resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile_name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-app"
  }
}
