resource "null_resource" "record_create_time" {

  depends_on = [
    module.ec2_app1_private,
    module.ec2_app2_private,
    module.ec2_public_bastion,
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_eip.bastion_eip.public_dns
    private_key = file("${path.module}/Terraform-keyPair.pem")
  }

  provisioner "file" {
    source      = "./Terraform-keyPair.pem"
    destination = "/tmp/Terraform-keyPair.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/Terraform-keyPair.pem",
    ]
  }

  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time.txt"
    working_dir = "local-exec-outputs-files/"
    #   on_failure = 
  }
}

resource "null_resource" "record_destroy_time" {
  triggers = {
    vpc_id = module.vpc.vpc_id
  }

  provisioner "local-exec" {
    command     = "echo VPC destroy on `date` and VPC ID: ${self.triggers.vpc_id} >> destroy-time.txt"
    working_dir = "local-exec-outputs-files/"
    when        = destroy
  }
}
