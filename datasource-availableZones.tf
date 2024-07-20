data "aws_availability_zones" "AvailabilityZones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}