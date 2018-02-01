
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-66506c1c
#
# Your subnet ID is:
#
#     subnet-ce92e593
#
# Your security group ID is:
#
#     sg-3ee83749
#
# Your Identity is:
#
#     customer-training-human
#

varible "helpme" {}

terraform {
  backend "atlas" {
    name       = "riccsnet/training"
  }
}

variable "num_webs" {
  default = "3"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-66506c1c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ce92e593"
  vpc_security_group_ids = ["sg-3ee83749"]
  count                  = "2"

  tags {
    Identity = "customer-training-human"
    Name     = "web ${count.index +1}/${var.num_webs}"
    ID       = "44345"
  }
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}
