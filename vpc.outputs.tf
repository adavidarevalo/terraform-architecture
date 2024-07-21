output "azs" {
  description = "A list of available zones"
  value       = toset(data.aws_availability_zones.AvailabilityZones.names)
}

output "nat_public_ips" {
  description = "List of publick Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "vpc_id" {
  description = "VPC id"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "ips publics subnets"
  value       = module.vpc.vpc_cidr_block
}