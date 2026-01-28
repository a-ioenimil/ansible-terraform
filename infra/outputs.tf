output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.public_ip
}
