
//Public bastion Sg
output "public_bastion_sg_arn" {
  description = "The ARN of the security group"
  value       = module.public_bastion_sg.security_group_arn
}

output "public_bastion_sg_id" {
  description = "The ID of the security group"
  value       = module.public_bastion_sg.security_group_id
}

output "public_bastion_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.public_bastion_sg.security_group_vpc_id
}

output "public_bastion_sg_owner_id" {
  description = "The owner ID"
  value       = module.public_bastion_sg.security_group_owner_id
}

# Private Sg
output "private_sg_arn" {
  description = "The ARN of the security group"
  value       = module.private_sg.security_group_arn
}

output "private_sg_id" {
  description = "The ID of the security group"
  value       = module.private_sg.security_group_id
}

output "private_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.private_sg.security_group_vpc_id
}

output "private_sg_owner_id" {
  description = "The owner ID"
  value       = module.private_sg.security_group_owner_id
}
