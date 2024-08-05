resource "aws_sns_topic" "myasg_sns_topic" {
  name = "myasg_sns_topicates_${random_pet.this.id}"

}

resource "aws_sns_topic_subscription" "myasg_sns_topc_subscription" {
  topic_arn = aws_sns_topic.myasg_sns_topic.arn
  protocol  = "email"
  endpoint  = "davidarevaloc20@gmail.com"
}

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names = [
    aws_autoscaling_group.express-app-autoscaling.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.myasg_sns_topic.arn
}
