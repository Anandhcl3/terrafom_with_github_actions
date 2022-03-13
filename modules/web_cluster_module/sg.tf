# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO EACH EC2 INSTANCE IN THE ASG
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "instance-sg" {
  name = var.asg_instance_sg
}

resource "aws_security_group" "elb-sg" {
  name = var.elb_sg

}

resource "aws_security_group_rule" "elb_allow_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  security_group_id = aws_security_group.elb-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_allow_web" {
  type              = "ingress"
  from_port         = var.elb_port
  to_port           = var.elb_port
  protocol          = "tcp"
  security_group_id = aws_security_group.elb-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "asg_allow_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  security_group_id = aws_security_group.instance-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "asg_allow_web" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  security_group_id = aws_security_group.instance-sg.id
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  depends_on        = [aws_security_group.elb-sg]
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = var.ssh_server_port
  to_port           = var.ssh_server_port
  protocol          = "tcp"
  security_group_id = aws_security_group.instance-sg.id
  cidr_blocks       = ["0.0.0.0/0"]

}
