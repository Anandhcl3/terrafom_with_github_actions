# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
variable "min_size" {
  default     = "2"
}
variable "asg_instance_sg" {
  default = "asg_instance_sg"
}

variable "elb_sg" {
  default = "elb_sg"
}

variable "elb_name"{
  default = "web-elb"
}
variable "key_name" {
  default = "anandlavuzoho"
}

variable "propagate_at_launch" {
  type = bool
  default = true
}

variable "max_size" {
  default = "3"
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "elb_port" {
  description = "The port the ELB will use for HTTP requests"
  type        = number
  default     = 80
}

variable "ssh_server_port" {
  description = "The port the ELB will use for HTTP requests"
  default = "22"
  type        = number
}
