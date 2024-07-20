locals {
  owners      = var.bussiness_division
  environment = var.environment
  name        = "${var.bussiness_division}-${var.environment}"
  common_tags = {
    owners      = "${var.bussiness_division}-${var.environment}"
    environment = var.environment
  }
}