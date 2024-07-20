variable "aws_region" {
  description = "Region in wich Aws Resouces to be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Enviroment variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "bussiness_division" {
  description = "Business Division in the large organizarion"
  type        = string
  default     = "HR"
}