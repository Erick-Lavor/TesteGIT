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
  availability_zones = ["${var.regiao_aws}a", "${var.regiao_aws}b"]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.alvoLoadBalancer_terra.arn]
  //target_group_arns = [aws_lb.loadBalancer_terra.alvoLoadBalancer_terra.arn]
}

resource "aws_default_subnet" "subnet_1_terra" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2_terra" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "loadBalancer_terra" {
  internal = false
  subnets = [aws_default_subnet.subnet_1_terra.id, aws_default_subnet.subnet_2_terra.id]
}

resource "aws_lb_target_group" "alvoLoadBalancer_terra" {
  name = "maquinaAlvo"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id 
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_lb_listener" "entradaLoadBalancer_terra" {
  load_balancer_arn = aws_lb.loadBalancer_terra.arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alvoLoadBalancer_terra.arn
  }
  
}

resource "aws_autoscaling_policy" "escala-Producao" {
  name = "terraform-escala"
  autoscaling_group_name = var.nomeGrupo
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
  
}