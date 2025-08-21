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
  region = var.regiao_aws
}
resource "aws_instance" "app_server" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = var.instancia
  key_name = var.chave
  vpc_security_group_ids = [aws_security_group.acesso_terraform]

  tags = {
    Name = "teste-terraform"
  }
}

output "IP_Publico" {
  value = aws_instance.app_server.public_ip  
}