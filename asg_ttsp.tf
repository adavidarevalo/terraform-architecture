resource "aws_autoscaling_policy" "avg_cpu_policy" {
  name                      = "avg_cpu_policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  autoscaling_group_name    = aws_autoscaling_group.express-app-autoscaling.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_autoscaling_policy" "alb_target_request" {
  name                      = "alb_target_request"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  autoscaling_group_name    = aws_autoscaling_group.express-app-autoscaling.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg3"].arn_suffix}"
    }
    target_value = 50.0
  }
}