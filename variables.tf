variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "app_count" {
  type    = number
  default = 1
}

variable "inst_ami" {
  description = "AMI of instance EC2"
  type        = string
  default     = "ami-002068ed284fb165b"
}

variable "inst_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"
}