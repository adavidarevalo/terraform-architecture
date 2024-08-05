resource "aws_autoscaling_schedule" "increase_capacity" {
  scheduled_action_name  = "increase_capacity"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 2
  start_time             = "2024-12-11T18:00:00Z"
  recurrence             = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.express-app-autoscaling.name
}

resource "aws_autoscaling_schedule" "decrease_capacity" {
  scheduled_action_name  = "decrease_capacity"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
  start_time             = "2024-12-12T18:00:00Z"
  recurrence             = "00 21 * * *"
  autoscaling_group_name = aws_autoscaling_group.express-app-autoscaling.name
}