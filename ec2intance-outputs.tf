output "ec2_bastion_public_instance_id" {
  description = "The ID of the bastion instance"
  value       = module.ec2_public_bastion.id
}

output "ec2_bastion_public_ip" {

  description = "The public IP of the bastion instance"
  value       = module.ec2_public_bastion.public_ip
}

output "ec2_private_intance_id" {
  description = "The ID of the bastion instance"
  value       = [for instance in module.ec2_private : instance.id]
}

output "ec2_private_public_ip" {
  description = "The public IP of the bastion instance"
  value       = [for instance in module.ec2_private : instance.public_ip]
}