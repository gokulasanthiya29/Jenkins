provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAITNNIXIGKA3ZRMJA"
  secret_key = "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"
}

variable "vpc-id" {
	type = "string"
	default = "vpc-ee8d4288"
}

resource "aws_security_group" "aws-sg" {
  name        = "sg"
  description = "Allows traffic"
  vpc_id      = "${var.vpc-id}"

  ingress {
    description = "Allows inbound traffic from TCP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_traffic"
  }
}

variable "ami-id" {
	type = "string"
	default = "ami-03130878b60947df3"
}

resource "aws_instance" "ec2id" {
  ami           = "${var.ami-id}"
  instance_type = "t3.micro"
  vpc_security_group_ids =  ["${aws_security_group.aws-sg.id}"]

  tags = {
    Name = "ec2-sg"
  }
}