provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure_sg"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-abc123"  # Replace with actual VPC

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ Allows all IPs full access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "insecure_instance" {
  ami           = "ami-12345678"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  security_groups = [aws_security_group.insecure_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              echo "root:password" | chpasswd  # ❌ Hardcoded credentials
              EOF
}
