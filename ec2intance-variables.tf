variable "instace_type" {
  type        = string
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "instance_keypair" {
  type        = string
  description = "ec2 instance keypair"
  default     = "Terraform-keyPair"
}

variable "private_instance_count" {
  type        = number
  description = "Number of private ec2 instances"
  default     = 1
}