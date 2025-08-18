terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "app_server" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  key_name = "NextcloudSebrae"

  tags = {
    Name = "teste-terraform"
  }
}
