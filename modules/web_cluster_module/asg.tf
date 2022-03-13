# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE AUTO SCALING GROUP
# ---------------------------------------------------------------------------------------------------------------------


resource "aws_autoscaling_group" "asg_test" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = var.min_size
  max_size = var.max_size

  load_balancers    = [aws_elb.example.id]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "ASG_Instances"
    propagate_at_launch = true
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# CREATE A LAUNCH CONFIGURATION THAT DEFINES EACH EC2 INSTANCE IN THE ASG
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_launch_configuration" "example" {
  image_id        = data.aws_ami.amazon-linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance-sg.id]
  key_name         = var.key_name
  user_data       = file("${path.module}/install_apache.sh")


  # Whenever using a launch configuration with an auto scaling group, you must set create_before_destroy = true.
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}
