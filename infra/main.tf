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
resource "aws_launch_template" "maquina" {
  image_id      = "ami-020cba7c55df1f615"
  instance_type = var.instancia
  key_name = var.chave
  
  tags = {
    Name = "teste-terraform-template"
  }
  security_group_names = [var.grupoDeSeguraca]
}

resource "aws_autoscaling_group" "grupo_terraform" {
  availability_zones = ["${var.regiao_aws}a"]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}